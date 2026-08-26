-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupFightViewLevel.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupFightViewLevel", package.seeall)

local Rouge2_HeroGroupFightViewLevel = class("Rouge2_HeroGroupFightViewLevel", HeroGroupFightViewLevel)

function Rouge2_HeroGroupFightViewLevel:onInitView()
	Rouge2_HeroGroupFightViewLevel.super.onInitView(self)

	self._goTargetContain = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain")
	self._goRougeTarget = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rougeTarget")
	self._txtRougeTitle = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rougeTarget/txt_dec")
	self._btnRougeDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rougeTarget/txt_dec/#btn_detail")
	self._goRougeTargetTips = gohelper.findChild(self.viewGO, "#go_rougeTargetTips")
	self._goLayout = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rougeTarget/layout")
end

function Rouge2_HeroGroupFightViewLevel:addEvents()
	Rouge2_HeroGroupFightViewLevel.super.addEvents(self)
	self._btnRougeDetail:AddClickListener(self._btnRougeDetailOnClick, self)
end

function Rouge2_HeroGroupFightViewLevel:removeEvents()
	Rouge2_HeroGroupFightViewLevel.super.removeEvents(self)
	self._btnRougeDetail:RemoveClickListener()
end

function Rouge2_HeroGroupFightViewLevel:_btnRougeDetailOnClick()
	self._funnyTaskTips:show()
end

function Rouge2_HeroGroupFightViewLevel:onOpen()
	Rouge2_HeroGroupFightViewLevel.super.onOpen(self)

	local episodeId = HeroGroupModel.instance.episodeId

	self._funnyTaskTips = Rouge2_FightFunnyTaskTips.Get(self._goRougeTargetTips, episodeId)
end

function Rouge2_HeroGroupFightViewLevel:_refreshTarget()
	Rouge2_HeroGroupFightViewLevel.super._refreshTarget(self)
	self:refreshFunnyTask()
end

function Rouge2_HeroGroupFightViewLevel:refreshFunnyTask()
	self._funnyTaskIdList = Rouge2_MapConfig.instance:getFunnyTaskIdList(self._episodeId)
	self._hasFunnyTask = self._funnyTaskIdList and #self._funnyTaskIdList > 0

	gohelper.setActive(self._goRougeTarget, self._hasFunnyTask)
	gohelper.setActive(self._goTargetContain, not self._hasFunnyTask)

	if not self._hasFunnyTask then
		return
	end

	self._funnyTaskTitle = Rouge2_MapConfig.instance:getFunnyTaskTitle(self._episodeId)
	self._txtRougeTitle.text = self._funnyTaskTitle

	self:refreshFunnyTaskRewards()
end

function Rouge2_HeroGroupFightViewLevel:_btnenemyOnClick()
	if self._fixHpRate then
		EnemyInfoController.instance:openRougeEnemyInfoView(self._battleId, 1 + tonumber(self._fixHpRate))

		return
	end

	local nodeId = 0

	if Rouge2_MapModel.instance:isNormalLayer() then
		local node = Rouge2_MapModel.instance:getCurNode()

		nodeId = node and node.nodeId
	end

	Rouge2_Rpc.instance:sendRouge2MonsterFixAttrRequest(nodeId, self._onGetFixAttrRequest, self)
end

function Rouge2_HeroGroupFightViewLevel:_onGetFixAttrRequest(req, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._fixHpRate = msg.fixHpRate

	EnemyInfoController.instance:openRougeEnemyInfoView(self._battleId, 1 + tonumber(self._fixHpRate))
end

function Rouge2_HeroGroupFightViewLevel:refreshFunnyTaskRewards()
	local rewardNumStr = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.FunnyTaskRewardNum].value
	local rewardNumList = GameUtil.splitString2(rewardNumStr)
	local rewardNumMap = {}

	if rewardNumList then
		for _, rewardInfo in ipairs(rewardNumList) do
			local levelName = rewardInfo[1]
			local level = FightEnum.Rouge2FunnyTaskLevelName2Level[levelName]

			rewardNumMap[level] = tonumber(rewardInfo[2])
		end
	end

	for _, level in pairs(FightEnum.Rouge2FunnyTaskLevel) do
		local levelName = FightEnum.Rouge2FunnyTaskLevelName[level]
		local goIcon = gohelper.findChild(self._goLayout, "image_" .. string.lower(levelName))
		local txtNum = gohelper.findChildText(goIcon, "#txt_num")

		if not rewardNumMap[level] then
			local rewardNum = 0
			local isShow = rewardNum > 0

			gohelper.setActive(goIcon, isShow)

			if isShow then
				txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), rewardNum)
			end
		end
	end
end

return Rouge2_HeroGroupFightViewLevel
