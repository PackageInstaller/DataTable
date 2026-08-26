-- chunkname: @modules/logic/abyss/view/AbyssRewardItem.lua

module("modules.logic.abyss.view.AbyssRewardItem", package.seeall)

local AbyssRewardItem = class("AbyssRewardItem", LuaCompBase)

function AbyssRewardItem:init(go)
	self.viewGO = go
	self._imagequality = gohelper.findChildImage(self.viewGO, "rewarditem/#simage_quality")
	self._simagerewardicon = gohelper.findChildSingleImage(self.viewGO, "rewarditem/#simage_rewardicon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._txtinfo = gohelper.findChildText(self.viewGO, "#txt_info")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssRewardItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnAbyssTaskUpdate, self.refreshReward, self)
end

function AbyssRewardItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnAbyssTaskUpdate, self.refreshReward, self)
end

function AbyssRewardItem:_btnclickOnClick()
	AbyssController.instance:openTaskView()
end

function AbyssRewardItem:_editableInitView()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V3a6Abyss)
end

function AbyssRewardItem:setInfo(actId)
	self.actId = actId

	self:refreshReward()
end

function AbyssRewardItem:refreshReward()
	local taskConfigList = AbyssConfig.instance:getTaskConfigListByActId(self.actId)

	if not taskConfigList or next(taskConfigList) == nil then
		logError("新深渊 不存在任务配置 actId:" .. self.actId)

		return
	end

	local constConfig = AbyssConfig.instance:getConstConfig(AbyssEnum.ConstId.TargetBonus)

	if not constConfig then
		logError("新深渊 不存在常量配置 constId:" .. tostring(self.actId))

		return
	end

	local targetParam = string.splitToNumber(constConfig.value, "#")
	local targetType = targetParam[1]
	local targetItemId = targetParam[2]
	local maxRewardCount = 0
	local getRewardCount = 0
	local taskType = TaskEnum.TaskType.Abyss
	local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(targetType, targetItemId, true)

	self._simagerewardicon:LoadImage(icon)

	for _, config in ipairs(taskConfigList) do
		local bonusParamList = string.split(config.bonus, "|")

		if bonusParamList and next(bonusParamList) then
			for _, param in ipairs(bonusParamList) do
				local data = string.splitToNumber(param, "#")

				if data[2] == targetItemId then
					maxRewardCount = maxRewardCount + data[3]

					if TaskModel.instance:isTaskFinish(taskType, config.id) then
						getRewardCount = getRewardCount + data[3]
					end
				end
			end
		end
	end

	self._txtnum.text = string.format("<size=60>%s<#D0DBF1></color></size>/%s", getRewardCount, maxRewardCount)
	self._txtinfo.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v3a6_abyss_reward_desc"), itemConfig.name)
end

function AbyssRewardItem:onDestroy()
	return
end

return AbyssRewardItem
