-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\AVG\\ChapterEndPanel.lua

local ResTalkChapterEnd = require("ClientData/ResTalkChapterEnd")
local strClassName = "ChapterEndPanel"
local ChapterEndPanel = Class(strClassName, UIControls.Child)

function ChapterEndPanel:ctor(...)
	self:initUI()
end

function ChapterEndPanel:initUI(...)
	self.panelAni = UIControls.UIAni(self, "")
	self.letterTxt = UIControls.Label(self, "BgContent/Mask/TextContent")
	self.signTxt = UIControls.Label(self, "BgContent/Mask/TextSign")
	self.letterImg = UIControls.Image(self, "BgContent/IconDiff")
	self.photoImg = UIControls.RawImage(self, "BgPhoto/ImgPhoto")
end

function ChapterEndPanel:showChapterEnd(chapterEndId, endCallback)
	if not ResTalkChapterEnd[chapterEndId] then
		return
	end

	self.endCallback = endCallback

	local panelInfo = ResTalkChapterEnd[chapterEndId]

	self.letterTxt:setText(panelInfo.letter or "")
	self.signTxt:setText(panelInfo.name or "")

	local imgPath = panelInfo.image_path
	local imgName = panelInfo.image_name

	if imgPath and imgName then
		self.letterImg:setImage(imgPath, imgName)
	end

	local photoPath = panelInfo.photo

	if photoPath then
		self.photoImg:setImage(photoPath)
	end
end

function ChapterEndPanel:onOpen(...)
	self.panelAni:startAni("ShowAVGChapterEnd", true)

	self.inOpenAni = true
	self.startAniTime = Time.time

	ChapterEndPanel.super.onOpen(self)
end

local OPEN_ANI_LENGTH = 2

function ChapterEndPanel:onClickNext(...)
	if self.inOpenAni and Time.time - self.startAniTime >= OPEN_ANI_LENGTH then
		self.inOpenAni = nil
	end

	if self.inOpenAni then
		self:_interruptInAni()

		self.inOpenAni = nil
	elseif self.endCallback then
		self.endCallback()
	end
end

function ChapterEndPanel:_interruptInAni(...)
	self.panelAni:startAni("ResetAVGChapterEnd", true)
end

return ChapterEndPanel
