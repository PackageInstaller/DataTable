-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\AVG\\SectionIntroPanel.lua

local ResTalkSectionIntro = require("ClientData/ResTalkSectionIntro")
local AvgConfig = require("DesignerScript/AvgConfig")
local strClassName = "SectionIntroPanel"
local SectionIntroPanel = Class(strClassName, UIControls.Child)

function SectionIntroPanel:ctor(...)
	self:initUI()
end

function SectionIntroPanel:initUI(...)
	self.contextTxt = UIControls.Label(self, "BgCook/Text")
	self.rootAni = UIControls.UIAni(self, "")

	self.rootAni:addEventFinish(self._onAniFinish)
end

function SectionIntroPanel:showSectionIntro(sectionIntroId, endCallback)
	local introInfo = ResTalkSectionIntro[sectionIntroId]

	if not introInfo then
		return
	end

	self.showTime = introInfo.show_time or 2
	self.context = introInfo.context or ""
	self.endCallback = endCallback

	self.contextTxt:setText("")
	self:_startCloseTimer()
end

function SectionIntroPanel:onSectionInfoEnd()
	self:_stopCloseTimer()

	if self.endCallback then
		self.endCallback()
	end
end

function SectionIntroPanel:_onAniFinish(aniCom, aniName)
	if aniName == "ShowEveAVG" then
		self.contextTxt:setAvgText(self.context, AvgConfig.LABEL_JUMP_INTERVAL)
	end
end

function SectionIntroPanel:_startCloseTimer(...)
	self:_stopCloseTimer()

	self.closeTimer = Timer.New(Slot(self.onSectionInfoEnd, self), self.showTime)

	self.closeTimer:Start()
end

function SectionIntroPanel:_stopCloseTimer(...)
	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end
end

function SectionIntroPanel.getPrefabPath(sectionIntroId)
	if not ResTalkSectionIntro[sectionIntroId] or not ResTalkSectionIntro[sectionIntroId].path then
		return
	end

	return ResTalkSectionIntro[sectionIntroId].path
end

return SectionIntroPanel
