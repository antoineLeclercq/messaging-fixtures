require_relative '../../../automated_init'

context "Handler" do
  context "Assert Written" do
    context "Block" do
      context "Block Parameter" do
        handler = Controls::Handler.example
        message = Controls::Message.example

        output_message_class = Controls::Event::Output

        fixture = Handler.build(handler, message)

        fixture.()

        parameter = nil
        fixture.assert_written(output_message_class) do |f|
          parameter = f
        end

        test "WrittenMessage fixture" do
          assert(parameter.is_a?(WrittenMessage))
        end
      end
    end
  end
end
