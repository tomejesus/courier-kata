require 'compiler'

describe Compiler do
  let(:compiler) { described_class.new }

  describe '#initialize' do
    it 'has an of a sizer from the Sizer class' do
      expect(compiler.sizer).to be_an_instance_of(Sizer)
    end

    it 'has an of a calculator from the Sizer class' do
      expect(compiler.calculator).to be_an_instance_of(Calculator)
    end
  end

  describe '#header' do
    it 'compiles a header for the tables' do
      expect(compiler.header.delete(' ')).to eq(
        "
        | TYPE          | COST            |
        |---------------------------------|
        ".delete(' ')
      )
    end
  end

  describe '#parcel_output' do
    it 'compiles the cost output of a small parcel' do
      sizer = generate_small_sizer
      parcel = generate_small_parcel
      calculator = generate_small_calculator
      compiler = described_class.new(sizer: sizer, calculator: calculator)
      expect(compiler.parcel_output(parcel).delete(' ')).to eq(
        "| Small         | $3.00           |
        |---------------------------------|
        ".delete(' ')
      )
    end

    it 'compiles the cost output of a heavy parcel' do
      sizer = generate_small_sizer
      weigher = generate_five_weigher
      parcel = generate_heavy_parcel
      calculator = generate_heavy_calculator
      compiler = described_class.new(sizer: sizer, weigher: weigher, calculator: calculator)
      expect(compiler.parcel_output(parcel).delete(' ')).to eq(
        "| Heavy         | $50.00          |
        |---------------------------------|
        ".delete(' ')
      )
    end
  end

  describe '#batch_output' do
    it 'compiles the cost output of a batch of small parcels' do
      sizer = generate_small_sizer
      parcel = generate_small_parcel
      calculator = generate_small_calculator
      batch = generate_batch(parcel, parcel, parcel)
      compiler = described_class.new(sizer: sizer, calculator: calculator)
      expect(compiler.batch_output(batch).delete(' ')).to eq(
        "| Small         | $3.00           |
        |---------------------------------|
        | Small         | $3.00           |
        |---------------------------------|
        | Small         | $3.00           |
        |---------------------------------|
        ".delete(' ')
      )
    end
  end

  describe '#discount_output' do
    it 'compiles the cost output of a discount' do
      parcel = generate_small_parcel
      batch = generate_batch(parcel, parcel, parcel)
      compiler = described_class.new
      expect(compiler.discount_output(batch).delete(' ')).to eq(
        "| Discount      | -$3.00          |
        |---------------------------------|
        ".delete(' ')
      )
    end
  end

  describe '#speedy_output' do
    it 'compiles the cost output of a speedy delivery' do
      sizer = generate_small_sizer
      parcel = generate_small_parcel
      calculator = generate_small_calculator
      batch = generate_batch(parcel, parcel, parcel)
      compiler = described_class.new(sizer: sizer, calculator: calculator)
      expect(compiler.speedy_output(batch).delete(' ')).to eq(
        "| Speedy        | $9.00           |
        |---------------------------------|
        ".delete(' ')
      )
    end
  end

  describe '#footer' do
    it 'compiles a footer given a batch of small parcels with normal delivery' do
      sizer = generate_small_sizer
      parcel = generate_small_parcel
      calculator = generate_small_calculator
      batch = generate_batch(parcel, parcel, parcel)
      compiler = described_class.new(sizer: sizer, calculator: calculator)
      expect(compiler.footer(batch).delete(' ')).to eq(
        "| TOTAL         | $9.00           |
       |=================================|
        ".delete(' ')
      )
    end

    it 'compiles a footer given a batch of small parcels with speedy delivery' do
      sizer = generate_small_sizer
      parcel = generate_small_parcel
      calculator = generate_small_calculator
      batch = generate_batch(parcel, parcel, parcel)
      compiler = described_class.new(sizer: sizer, calculator: calculator)
      expect(compiler.footer(batch, true).delete(' ')).to eq(
        "| TOTAL         | $18.00          |
       |=================================|
        ".delete(' ')
      )
    end
  end

  describe '#fix_width' do
    it 'truncates a long string to 13 characters' do
      expect(compiler.fix_width('12345678901234567890')).to eq('1234567890123 ')
    end

    it 'extends a short string/symbol to 13 characters' do
      expect(compiler.fix_width('12345')).to eq('12345         ')
    end
  end
end
