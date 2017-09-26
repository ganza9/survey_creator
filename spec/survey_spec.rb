require('spec_helper')
require('pry')




describe(Survey)do
  describe('capitalize')do
    it('will capitalize the first letter of each word')do
      survey = Survey.new({:name => 'this is a test'})
      survey.save()
      survey_list =Survey.all()
      expect(survey_list[0].name).to(eq("This Is A Test"))
    end
  end
end
