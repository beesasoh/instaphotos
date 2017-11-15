require 'rails_helper'

describe ApplicationHelper do

  describe 'alert_for' do
    it 'Returns the class for an alert' do
      expect(helper.alert_for('success')).to  eq('alert-success')
      expect(helper.alert_for('error')).to    eq('alert-danger')
      expect(helper.alert_for('alert')).to    eq('alert-warning')
      expect(helper.alert_for('notice')).to   eq('alert-info')
    end
  end

  describe 'icon_link' do
    it 'returns html for icon with link' do
      test_path = posts_path
      test_icon = 'camera'
      expected_html = "<a href=\"#{test_path}\"><i class='material-icons'>#{test_icon}</i></a>"

      expect(helper.icon_link(test_path, test_icon)).to eq(expected_html)
    end
  end

end
