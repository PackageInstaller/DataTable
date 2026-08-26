-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillListItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillListItem", package.seeall)

local Rouge2_BackpackSkillListItem = class("Rouge2_BackpackSkillListItem", ListScrollCell)

function Rouge2_BackpackSkillListItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "go_Root")
	self._goCheck = gohelper.findChild(self.go, "go_Check")
end

function Rouge2_BackpackSkillListItem:addEventListeners()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnScrollSkillBag, self._onScrollSkillBag, self)
end

function Rouge2_BackpackSkillListItem:initInternal(go, view)
	Rouge2_BackpackSkillListItem.super.initInternal(self, go, view)

	local goScroll = gohelper.findChild(view.viewGO, view._param.scrollGOPath)
	local goCommonSkill = view:getResInst(Rouge2_Enum.ResPath.CommonSkillItem, self._goRoot)

	self._commonSkillItem = Rouge2_CommonSkillItem.Get(goCommonSkill)

	self._commonSkillItem:initDetailClickCallback(self._detailClickCallback, self)
	self._commonSkillItem:setParentScroll(goScroll)
	self._commonSkillItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.BackpackSkill)

	local goReddot = self._commonSkillItem:getReddotGo()

	self._reddotComp = Rouge2_BackpackItemReddotComp.Get(goReddot, self._goCheck, goScroll)
end

function Rouge2_BackpackSkillListItem:_detailClickCallback(dataType, dataId)
	local params = {
		dataType = dataType,
		selectSkillDataId = dataId
	}

	Rouge2_ViewHelper.openAttributeDetailView(nil, nil, params)
end

function Rouge2_BackpackSkillListItem:onUpdateMO(skillMo)
	local skillUid = skillMo:getUid()

	self._commonSkillItem:onUpdateMO(self._index, Rouge2_MapEnum.ItemDropViewEnum.Tips, Rouge2_Enum.ItemDataType.Server, skillUid)

	local reddotId = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.ActiveSkill]

	self._reddotComp:intReddotInfo(reddotId, skillUid)
end

function Rouge2_BackpackSkillListItem:_onScrollSkillBag()
	self._reddotComp:refresh()
end

return Rouge2_BackpackSkillListItem
