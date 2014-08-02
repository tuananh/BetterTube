# Title: A better YouTube embed tag for Jekyll
# Author: Tuan Anh Tran <http://tuananh.org>
# Description: Out put a beautiful thumbnail image. Change to iframe on click.
# Examples: 
# {% youtube /v8o-Vd__I-A 560 315 %}
# {% youtube http://youtu.be/v8o-Vd__I-A %}

module Jekyll
  class BetterTube < Liquid::Tag
    @ytid = nil
    @width = ''
    @height = ''

    def initialize(tag_name, markup, tokens)
      if markup =~ /(?:(?:https?:\/\/)?(?:www.youtube.com\/(?:embed\/|watch\?v=)|youtu.be\/)?(\S+)(?:\?rel=\d)?)(?:\s+(\d+)\s(\d+))?/i
        @ytid = $1
        @width = $2 || "560"
        @height = $3 || "315"
      end
      super
    end

    def render(context)
      ouptut = super
      if @ytid
        id = @ytid
        w = @width
        h = @height
        intrinsic = ((h.to_f / w.to_f) * 100)
        padding_bottom = ("%.2f" % intrinsic).to_s  + "%"

        thumbnail = "<figure class='BetterTube' data-youtube-id='#{id}' data-player-width='#{w}' data-player-height='#{h}' id='#{id}' style='padding-bottom: #{padding_bottom}'><a class='BetterTubePlayer' href='http://www.youtube.com/watch?v=a_426RiwST8' style='background: url(http://img.youtube.com/vi/#{id}/hqdefault.jpg) 50% 50% no-repeat rgb(0, 0, 0);'></a><div class='BetterTube-playBtn'></div>&nbsp;</figure>"
        
        video = %Q{#{thumbnail}}

      else
        "Error while processing. Try: {% youtube video_id [width height] %}"
      end
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::BetterTube)