# frozen-string-literal: true

class LocalFetcher
  def initialize(local_dirs, load_dir)
    @local_dirs = local_dirs
    @load_dir = load_dir
  end

  def fetch
    puts @local_dirs
    # Enumerate **/*manifest.txt
    @local_dirs.each do |local_dir|
      Dir["#{local_dir}/*/*manifest.txt"].each do |manifest_file|
        manifest_base_dir = File.dirname(manifest_file)
        cai_files = []
        begin
          File.readlines(manifest_file).each do |cai_file|
            source_file_path = "#{manifest_base_dir}/#{cai_file}".chomp
            file_data = File.read(source_file_path)
            dest_file_path = "#{@load_dir}/combined_for_load.json"
            puts "Appending #{source_file_path} to #{dest_file_path}" 
            File.write(dest_file_path, file_data, mode: "a")
          end
        rescue => e
          puts e.inspect
        end
      end
    end
  end
end
