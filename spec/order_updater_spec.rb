require 'spec_helper'

describe OrderUpdater do
  let(:order_id) { Augury::Orders.save(Factories.order('number' => "R123")) }
  let(:store) { Factories.store('quickbooks' => { 'access_token' => 'qyprdUDbIJZOD8tgTynBSG0ViOLsS48KEl6cbMrHO9IrgXwT', 'access_secret' => 'TCT1y3gjPfZRuL6hg2nyx9xCJv4vxF3dXMjfKmap', 'realm' => '568190375' }) }
   let(:message) {{ 'order' => { 'actual' => Factories.order },
                                 'shipment_number' => 'H438105531460' }}


  subject { OrderUpdater.new( message, {
                                  'access_token' => 'qyprdUDbIJZOD8tgTynBSG0ViOLsS48KEl6cbMrHO9IrgXwT',
                                  'access_secret' => 'TCT1y3gjPfZRuL6hg2nyx9xCJv4vxF3dXMjfKmap',
                                  'realm' => '568190375' }) }

  it 'create item' do
    VCR.use_cassette('quickbooks_order_update_create_item') do
      subject.send(:create_item, "Shipping Charges", "Shipping Charges", 0, 0, 0, "Other Charge")
    end
  end
end
