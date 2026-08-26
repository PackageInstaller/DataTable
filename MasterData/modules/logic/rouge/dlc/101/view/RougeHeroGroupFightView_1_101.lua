-- chunkname: @modules/logic/rouge/dlc/101/view/RougeHeroGroupFightView_1_101.lua

module("modules.logic.rouge.dlc.101.view.RougeHeroGroupFightView_1_101", package.seeall)

local RougeHeroGroupFightView_1_101 = class("RougeHeroGroupFightView_1_101", BaseView)

function RougeHeroGroupFightView_1_101:onInitView()
	self._gorouge = gohelper.findChild(self.viewGO, "herogroupcontain/hero/heroitem/#go_rouge")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeHeroGroupFightView_1_101:onOpen()
	local curNode = RougeMapModel.instance:getCurNode()
	local eventMo = curNode and curNode.eventMo
	local supriseAttackList = eventMo and eventMo:getSurpriseAttackList()

	if not supriseAttackList or #supriseAttackList <= 0 then
		return
	end

	RougeDLCController101.instance:openRougeDangerousView()
end

function RougeHeroGroupFightView_1_101:_editableInitView()
	return
end

return RougeHeroGroupFightView_1_101
