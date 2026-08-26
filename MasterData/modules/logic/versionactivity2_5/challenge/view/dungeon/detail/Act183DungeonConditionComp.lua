-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonConditionComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonConditionComp", package.seeall)

local Act183DungeonConditionComp = class("Act183DungeonConditionComp", Act183DungeonBaseComp)

function Act183DungeonConditionComp:init(go)
	Act183DungeonConditionComp.super.init(self, go)

	self._txtconditionitem = gohelper.findChildText(self.go, "#go_conditiondescs/#txt_conditionitem")
	self._imageconditionstar = gohelper.findChildImage(self.go, "top/title/#image_conditionstar")

	Act183Helper.setEpisodeConditionStar(self._imageconditionstar, true)

	self._conditionItemTab = self:getUserDataTb_()
end

function Act183DungeonConditionComp:addEventListeners()
	return
end

function Act183DungeonConditionComp:removeEventListeners()
	return
end

function Act183DungeonConditionComp:updateInfo(episodeMo)
	Act183DungeonConditionComp.super.updateInfo(self, episodeMo)

	self._conditionIds = self._episodeMo:getConditionIds()
	self._isAllConditionPass = self._episodeMo:isAllConditionPass()
end

function Act183DungeonConditionComp:checkIsVisible()
	return self._conditionIds and #self._conditionIds > 0
end

function Act183DungeonConditionComp:show()
	Act183DungeonConditionComp.super.show(self)
	self:createObjList(self._conditionIds, self._conditionItemTab, self._txtconditionitem.gameObject, self._initConditionItemFunc, self._refreshConditionItemFunc, self._defaultItemFreeFunc)
	ZProj.UGUIHelper.SetGrayscale(self._imageconditionstar.gameObject, not self._isAllConditionPass)
end

function Act183DungeonConditionComp:_initConditionItemFunc(goItem)
	goItem.txtcondition = gohelper.onceAddComponent(goItem.go, gohelper.Type_TextMesh)

	SkillHelper.addHyperLinkClick(goItem.txtcondition)

	goItem.gostar = gohelper.findChild(goItem.go, "star")
end

function Act183DungeonConditionComp:_refreshConditionItemFunc(goItem, conditionId, index)
	local conditionCo = Act183Config.instance:getConditionCo(conditionId)

	if not conditionCo then
		return
	end

	goItem.txtcondition.text = SkillHelper.buildDesc(conditionCo.decs1)

	local isConditionPass = self._episodeMo:isConditionPass(conditionId)

	gohelper.setActive(goItem.gostar, isConditionPass)
end

function Act183DungeonConditionComp:onDestroy()
	Act183DungeonConditionComp.super.onDestroy(self)
end

return Act183DungeonConditionComp
