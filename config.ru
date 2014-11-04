use Rack::Static, :urls => [ "/form.js" ], :root => "dist"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open( 'dist/form.html', File::RDONLY )
  ]
}