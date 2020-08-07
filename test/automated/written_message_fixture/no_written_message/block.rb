require_relative '../../automated_init'

context "Written Message Fixture" do
  context "No Written Message" do
    context "Block Given" do
      input_message = Controls::Message.example

      output_message = nil

      fixture = WrittenMessage.build(output_message, input_message) {}

      fixture.()

      context "Skipped Tests Detail Notice" do
        printed = fixture.test_session.detail?('Remaining written message tests are skipped')

        test "Printed" do
          assert(printed)
        end
      end
    end
  end
end