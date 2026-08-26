-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_FightFunnyTaskTips.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_FightFunnyTaskTips", package.seeall)

local Rouge2_FightFunnyTaskTips = class("Rouge2_FightFunnyTaskTips", LuaCompBase)

function Rouge2_FightFunnyTaskTips.Get(go, episdoeId)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_FightFunnyTaskTips, episdoeId)
end

function Rouge2_FightFunnyTaskTips:ctor(episodeId)
	self._episodeId = episodeId
end

function Rouge2_FightFunnyTaskTips:init(go)
	self.go = go
	self._txtRougeTitle = gohelper.findChildText(self.go, "tips/#scroll_dec/viewport/content/#txt_title")
	self._goRougeDescList = gohelper.findChild(self.go, "tips/#scroll_dec/viewport/content/#go_desclist")
	self._goRougeDescItem = gohelper.findChild(self.go, "tips/#scroll_dec/viewport/content/#go_desclist/#txt_descitem")
	self._btnRougeClose = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self._isInit = false

	self:hide()
end

function Rouge2_FightFunnyTaskTips:addEventListeners()
	self._btnRougeClose:AddClickListener(self._btnRougeCloseOnClick, self)
end

function Rouge2_FightFunnyTaskTips:removeEventListeners()
	self._btnRougeClose:RemoveClickListener()
end

function Rouge2_FightFunnyTaskTips:_btnRougeCloseOnClick()
	self:hide()
end

function Rouge2_FightFunnyTaskTips:refreshFunnyTask()
	self._isInit = true
	self._funnyTaskIdList = Rouge2_MapConfig.instance:getFunnyTaskIdList(self._episodeId)
	self._hasFunnyTask = self._funnyTaskIdList and #self._funnyTaskIdList > 0

	if not self._hasFunnyTask then
		return
	end

	self._funnyTaskTitle = Rouge2_MapConfig.instance:getFunnyTaskTitle(self._episodeId)
	self._txtRougeTitle.text = self._funnyTaskTitle

	self:refreshTaskTips()
end

function Rouge2_FightFunnyTaskTips:refreshTaskTips()
	self._funnyTaskTipsList = {}

	for _, funnyTaskId in ipairs(self._funnyTaskIdList) do
		local funnyTaskCo = Rouge2_MapConfig.instance:getFunnyTaskCofig(funnyTaskId)

		if funnyTaskCo then
			if funnyTaskCo.isTopic == 1 then
				table.insert(self._funnyTaskTipsList, 1, funnyTaskCo.fightTaskinfo)
			else
				table.insert(self._funnyTaskTipsList, funnyTaskCo.fightTaskDetail)
			end
		end
	end

	gohelper.CreateObjList(self, self._refreshOneTaskTips, self._funnyTaskTipsList, self._goRougeDescList, self._goRougeDescItem)
end

function Rouge2_FightFunnyTaskTips:_refreshOneTaskTips(obj, funnyTaskDesc, index)
	local goPoint = gohelper.findChild(obj, "point")
	local txtDesc = obj:GetComponent(gohelper.Type_TextMesh)

	txtDesc.text = funnyTaskDesc

	gohelper.setActive(goPoint, index > 1)
end

function Rouge2_FightFunnyTaskTips:show()
	if not self._isInit then
		self:refreshFunnyTask()
	end

	gohelper.setActive(self.go, true)
end

function Rouge2_FightFunnyTaskTips:hide()
	gohelper.setActive(self.go, false)
end

return Rouge2_FightFunnyTaskTips
