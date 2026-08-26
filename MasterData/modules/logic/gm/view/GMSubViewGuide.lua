-- chunkname: @modules/logic/gm/view/GMSubViewGuide.lua

module("modules.logic.gm.view.GMSubViewGuide", package.seeall)

local GMSubViewGuide = class("GMSubViewGuide", GMSubViewBase)

function GMSubViewGuide:ctor()
	self.tabName = "指引"
end

function GMSubViewGuide:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)
	self:addTitleSplitLine("指引调试")
	self:addLabel("L1", "指引：")

	self._inpGuide = self:addInputText("L1", "", "[guide[#step]]")

	self.addButton(self, "L1", "开始", self._onClickGuideStart, self)
	self.addButton(self, "L1", "完成", self._onClickGuideFinish, self)
	self.addButton(self, "L1", "重置", self._onClickGuideReset, self)
	self.addButton(self, "L2", "指引状态", self._onClickGuideStatus, self)
	self.addButton(self, "L2", "指引屏蔽", self._onClickGuideForbid, self)
	self.addButton(self, "L2", "引导图预览", self._onClickHelpViewBrowse, self)
	self.addButton(self, "L2", "清空战斗指引记录", self._clearFightGuide, self)
	self:addTitleSplitLine("指引编辑")
	self.addButton(self, "L3", "打开指引编辑器", self._onClickGuideEditor, self)
	self:addWikiButton("L3", "http://doc.sl.com/pages/viewpage.action?pageId=31851464")
	self._inpGuide:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGuide, ""))
end

function GMSubViewGuide:_clearFightGuide()
	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, "")
	ToastController.instance:showToastWithString("清空成功，重启生效")
end

function GMSubViewGuide:_onClickGuideStatus()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMGuideStatusView)
end

function GMSubViewGuide:_onClickGuideForbid()
	local isForbid = GuideController.instance:isForbidGuides()

	GuideController.instance:forbidGuides(not isForbid)
end

function GMSubViewGuide:_onClickGuideStart()
	self:closeThis()

	local text = self._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, text)

	local paramList = string.splitToNumber(text, "#")
	local guideId = tonumber(paramList[1])
	local guideStep = tonumber(paramList[2]) or 0

	print(string.format("input guideId:%s,guideStep:%s", guideId, guideStep))

	local guideMO = GuideModel.instance:getById(guideId)

	GuideModel.instance:gmStartGuide(guideId, guideStep)

	if guideMO then
		GuideStepController.instance:clearFlow(guideId)

		guideMO.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. guideId)
		GuideRpc.instance:sendFinishGuideRequest(guideId, guideStep)
		logNormal(string.format("<color=#FFA500>set guideId:%s,guideStep:%s</color>", guideId, guideStep))
	elseif guideId then
		GuideController.instance:startGudie(guideId)
		logNormal("<color=#FFA500>start guide " .. guideId .. "</color>")
	end
end

function GMSubViewGuide:_onClickGuideFinish()
	local inputStr = self._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, inputStr)

	if not string.nilorempty(inputStr) then
		local guideId = tonumber(inputStr)

		if guideId then
			local guideMO = GuideModel.instance:getById(guideId)

			self:closeThis()
			logNormal("GM one key finish guide " .. guideId)

			local stepList = GuideConfig.instance:getStepList(guideId)

			for j = #stepList, 1, -1 do
				local stepCO = stepList[j]

				if stepCO.keyStep == 1 then
					GuideRpc.instance:sendFinishGuideRequest(guideId, stepCO.stepId)

					break
				end
			end
		else
			local guideStep = string.split(inputStr, "#")

			logNormal("GM one key finish guide " .. inputStr)
			GuideRpc.instance:sendFinishGuideRequest(tonumber(guideStep[1]), tonumber(guideStep[2]))
		end
	else
		logNormal("GM one key finish guides")
		GuideStepController.instance:clearStep()
		GuideController.instance:oneKeyFinishGuides()
	end
end

function GMSubViewGuide:_onClickGuideReset()
	local text = self._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, text)

	local paramList = string.splitToNumber(text, "#")
	local guideId = tonumber(paramList[1])
	local guideCfg = GuideConfig.instance:getGuideCO(guideId)

	if guideCfg then
		print(string.format("reset guideId:%s", guideId))
		GuideStepController.instance:clearFlow(guideId)
		GMRpc.instance:sendGMRequest("delete guide " .. guideId)

		local temp = string.split(guideCfg.trigger, "#")

		self:_resetEpisode(temp[1], temp[2])

		local invalidList = GameUtil.splitString2(guideCfg.invalid, false, "|", "#")

		if not invalidList then
			return
		end

		for _, one in ipairs(invalidList) do
			-- block empty
		end
	end
end

function GMSubViewGuide:_resetEpisode(type, episodeId)
	if type == "EpisodeFinish" or type == "EnterEpisode" then
		self:_doResetEpisode(tonumber(episodeId))

		return
	end

	local openConfig = lua_open.configDict[tonumber(episodeId)]

	if openConfig then
		self:_doResetEpisode(openConfig.episodeId)
	end
end

function GMSubViewGuide:_doResetEpisode(episodeId)
	local episodeCfg = lua_episode.configDict[episodeId]

	if not episodeCfg then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("set dungeon %s 0", episodeId))

	if episodeCfg.beforeStory > 0 then
		print(episodeId .. " delete beforeStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", episodeCfg.beforeStory))
	end

	if episodeCfg.afterStory > 0 then
		print(episodeId .. " delete afterStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", episodeCfg.afterStory))
	end
end

function GMSubViewGuide:_onClickGuideEditor()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GuideStepEditor)
end

function GMSubViewGuide:_onClickHelpViewBrowse()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMHelpViewBrowseView)
end

return GMSubViewGuide
