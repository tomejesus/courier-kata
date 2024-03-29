require 'discounter'

describe Discounter do
  let(:discounter) { described_class.new }
  let(:calculator) { Calculator.new }

  describe '#create_discount_object' do
    it 'changes the discount object' do
      batch_object = generate_batch_object
      expect do
        discounter.create_discount_object(batch_object, calculator)
      end.to change { discounter.discount_object }.from(
        Small: [], Medium: [], Other: []
      ).to(
        Small: [3.0, 3.0, 3.0, 3.0, 3.0],
        Medium: [12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0],
        Other: [51, 51, 15.0, 15.0, 15.0, 15.0, 15.0]
      )
    end
  end

  describe '#process_small_discount' do
    it 'removes 3 items from a small list and updates discount_amount' do
      batch_object = generate_batch_object
      discounter.create_discount_object(batch_object, calculator)
      expect do
        discounter.process_small_discount(discounter.discount_object[:Small])
      end.to change { discounter.discount_object[:Small] }.from(
        [3.0, 3.0, 3.0, 3.0, 3.0]
      ).to([3.0, 3.0])
      expect(discounter.discount_amount).to eq 3.0
    end
  end

  describe '#process_medium_discount' do
    it 'removes 4 items from a medium list and updates discount_amount' do
      batch_object = generate_batch_object
      discounter.create_discount_object(batch_object, calculator)
      expect do
        discounter.process_medium_discount(discounter.discount_object[:Medium])
      end.to change { discounter.discount_object[:Medium] }.from(
        [12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0]
      ).to([12.0, 12.0, 12.0])
      expect(discounter.discount_amount).to eq 12.0
    end
  end

  describe '#process_other_discount' do
    it 'removes all items from lists and updates discount_amount' do
      batch_object = generate_batch_object
      discounter.create_discount_object(batch_object, calculator)
      expect do
        discounter.process_other_discount([], [], discounter.discount_object[:Other])
      end.to change { discounter.discount_amount }.to(15.0)
    end
  end

  describe '#process_discount' do
    it 'removes all items from lists and updates discount_amount' do
      batch_object = generate_batch_object
      discounter.create_discount_object(batch_object, calculator)
      expect do
        discounter.process_discount(batch_object, calculator)
      end.to change { discounter.discount_amount }.to(33.0)
    end
  end
end
