-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\AVG\\ChapterPosterPanel.lua

local strClassName = "ChapterPosterPanel"
local ChapterPosterPanel = Class(strClassName, UIControls.Child)

function ChapterPosterPanel:ctor(...)
	self:initUI()
end

function ChapterPosterPanel:initUI(...)
	self.bgRawImage = UIControls.RawImage(self, "ImgPhoto")
	self.hdBgRawImage = UIControls.RawImage(self, "ImgPhoto02")
end

function ChapterPosterPanel:showChapterPoster(posterPath, hdPosterPath, endCallback)
	self.endCallback = endCallback

	if hdPosterPath then
		self.hdBgRawImage:setImage(hdPosterPath)
		self.hdBgRawImage:setVisible(true)
		self.bgRawImage:setVisible(false)
	else
		self.bgRawImage:setImage(posterPath)
		self.hdBgRawImage:setVisible(false)
		self.bgRawImage:setVisible(true)
	end
end

function ChapterPosterPanel:onOpen(...)
	ChapterPosterPanel.super.onOpen(self)
end

function ChapterPosterPanel:onClickNext(...)
	if self.endCallback then
		self.endCallback()
	end
end

return ChapterPosterPanel
