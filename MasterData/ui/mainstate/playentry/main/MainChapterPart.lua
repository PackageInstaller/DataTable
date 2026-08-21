-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\MainChapterPart.lua

local MainSeasonPanel = require("UI/MainState/PlayEntry/Main/MainSeasonPanel")
local MainChapterPart = Class("MainChapterPart", UIControls.Panel)

function MainChapterPart:ctor()
	self:initUI()
end

function MainChapterPart:initUI()
	self.btnPre = UIControls.Button(self, self.mPath .. "/BtnPre")

	self.btnPre:addEventClick(self.onBtnPreClick)

	self.btnNext = UIControls.Button(self, self.mPath .. "/BtnNext")

	self.btnNext:addEventClick(self.onBtnNextClick)

	self.btnBlock = UIControls.Button(self, self.mPath .. "/BtnBlock")

	self.btnBlock:addEventClick(self.onCloseClick)

	self.btnBack = UIControls.Button(self, self.mPath .. "/BtnBack")

	self.btnBack:addEventClick(self.onCloseClick)

	self.panelSeason = MainSeasonPanel(self, self.mPath, "System/MainBattle/MainLvChoosePanel", 0, 0, true)
	self.panelSeason.mEventChapterClick = Slot(self.onChapterSelect, self)
end

function MainChapterPart:show(tgtSeason)
	self.season = tgtSeason

	if CurAvatar == nil then
		return
	end

	local mainStageCur = CurAvatar.mainStageCur

	self.btnPre:setVisible(tgtSeason ~= 1)
	self.btnNext:setVisible(tgtSeason + 1 <= mainStageCur.season)

	local tgtChapter = mainStageCur.chapter

	if tgtSeason ~= mainStageCur.season then
		tgtChapter = nil
	end

	if mainStageCur and mainStageCur.season == 1 then
		tgtSeason = nil
	end

	self.panelSeason:show(tgtSeason, tgtChapter)
	self.panelSeason:showBar(tgtChapter)
	self:setVisible(true)
end

function MainChapterPart:onChapterSelect(chapter)
	if CurAvatar == nil then
		return
	end

	local mainStageCur = CurAvatar.mainStageCur
	local mainStageNext = CurAvatar:getNextMainStageInfo()
	local tgtStageInfo = CurAvatar:getMainStageInfo(self.season, chapter, 1)

	if CurAvatar:getMainStageState() == Const.STAGE_STATE_ATK_BF and tgtStageInfo.idx > mainStageCur.idx or mainStageNext and tgtStageInfo.idx > mainStageNext.idx then
		MsgManager.notice(Lang.get(30517))
	elseif mainStageCur.season == self.season and mainStageCur.chapter == chapter then
		self.mWindow.partStage:show(mainStageCur)
	else
		self.mWindow.partStage:show(tgtStageInfo)
	end

	self:setVisible(false)
end

function MainChapterPart:onCloseClick(sender)
	self:setVisible(false)
end

function MainChapterPart:onBtnPreClick(sender)
	self:show(self.season - 1)
end

function MainChapterPart:onBtnNextClick(sender)
	self:show(self.season + 1)
end

return MainChapterPart
