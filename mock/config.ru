class Zuul
  def call(env)
    [200, {'Content-Type' => 'text/plain'}, ["There is no #{env['QUERY_STRING']}. Only Zuul!"]]
  end
end

class ContentModifier
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    headers['Content-Length'] = "1000"
    [status, headers, response]
  end
end

use ContentModifier
run Zuul.new
