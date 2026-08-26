-- chunkname: @modules/logic/survival/view/map/SurvivalMapTreeOpenFogView.lua

module("modules.logic.survival.view.map.SurvivalMapTreeOpenFogView", package.seeall)

local SurvivalMapTreeOpenFogView = class("SurvivalMapTreeOpenFogView", BaseView)
local uinodes = {
	"BottomRight",
	"Left",
	"Top",
	"Bottom",
	"#go_lefttop"
}

function SurvivalMapTreeOpenFogView:onInitView()
	self._gotips = gohelper.findChild(self.viewGO, "#go_usedTips")
	self._txtTips = gohelper.findChildTextMesh(self.viewGO, "#go_usedTips/#txt_usedTips")
	self._allUIs = self:getUserDataTb_()

	for k, v in ipairs(uinodes) do
		self._allUIs[k] = gohelper.findChild(self.viewGO, v)
	end
end

function SurvivalMapTreeOpenFogView:addEvents()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnTreeOpenFog, self._onUseFog, self)
	self.viewContainer:registerCallback(SurvivalEvent.OnClickSurvivalScene, self._onSceneClick, self)
end

function SurvivalMapTreeOpenFogView:removeEvents()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnTreeOpenFog, self._onUseFog, self)
	self.viewContainer:unregisterCallback(SurvivalEvent.OnClickSurvivalScene, self._onSceneClick, self)
end

function SurvivalMapTreeOpenFogView:onOpen()
	gohelper.setActive(self._gotips, false)
end

function SurvivalMapTreeOpenFogView:_onUseFog(choiceData)
	if not choiceData then
		return
	end

	self._choiceData = choiceData

	local walkable = SurvivalMapModel.instance:getCurMapCo().walkables
	local playerPos = SurvivalMapModel.instance:getSceneMo().player.pos
	local list = SurvivalHelper.instance:getAllPointsByDis(playerPos, choiceData.openFogRange)

	for i = #list, 1, -1 do
		if list[i] == playerPos or not SurvivalHelper.instance:getValueFromDict(walkable, list[i]) then
			table.remove(list, i)
		end
	end

	self._allCanUsePoints = {}

	for _, v in ipairs(list) do
		table.insert(self._allCanUsePoints, v:clone())
		SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(-2, v.q, v.r, 2)
	end

	gohelper.setActive(self._gotips, true)

	for k, v in ipairs(self._allUIs) do
		gohelper.setActive(v, false)
	end

	self.viewContainer:setCloseFunc(self.cancelOpenFog, self)
end

function SurvivalMapTreeOpenFogView:_onSceneClick(hexPos, data)
	if not self._choiceData then
		return
	end

	data.use = true

	if tabletool.indexOf(self._allCanUsePoints, hexPos) then
		SurvivalStatHelper.instance:statSurvivalMapUnit("SelectOption", self._choiceData.unitId, self._choiceData.param, self._choiceData.treeId)
		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.SelectOption, string.format("%d#%d#%d", self._choiceData.param, hexPos.q, hexPos.r))
		self:clearData()
	else
		self:cancelOpenFog()
	end
end

function SurvivalMapTreeOpenFogView:clearData()
	gohelper.setActive(self._gotips, false)
	SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(-2)

	for k, v in ipairs(self._allUIs) do
		gohelper.setActive(v, true)
	end

	self.viewContainer:setCloseFunc()

	self._choiceData = nil
end

function SurvivalMapTreeOpenFogView:cancelOpenFog()
	self:clearData()

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	SurvivalMapHelper.instance:tryShowServerPanel(sceneMo.panel)
end

return SurvivalMapTreeOpenFogView
