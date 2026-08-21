-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/element/UnitCompMainSceneElementBase.lua

module("logic.extensions.mainui.scene.element.UnitCompMainSceneElementBase", package.seeall)

local M = class("UnitCompMainSceneElementBase")

function M:ctor(mainGo)
	self._unit = mainGo
	self.mainGO = mainGo.gameObject
	self._compList = {}
	self._show = nil
end

function M:Awake()
	self:_initComponents()

	local len = #self._compList

	for i = 1, len do
		self._compList[i]:onInit()
	end
end

function M:OnEnable()
	self._show = true

	self:_executeCompFunc("onEnable")
end

function M:OnDisable()
	self._show = false

	self:_executeCompFunc("onDisable")
end

function M:OnDestroy()
	self._show = nil

	self:_executeCompFunc("onDestroy")
end

function M:onLeaveScene(needUnloadRes)
	self:_executeCompFunc("onLeaveScene", needUnloadRes)
end

function M:onReturnScene(needUnloadRes)
	self:_executeCompFunc("onReturnScene", needUnloadRes)
end

function M:onReturnSceneFinished(needUnloadRes)
	self:_executeCompFunc("onReturnSceneFinished", needUnloadRes)
end

function M:_initComponents()
	return
end

function M:_executeCompFunc(funcName, ...)
	local len = #self._compList
	local tempComp

	for i = 1, len do
		tempComp = self._compList[i]

		if tempComp[funcName] then
			tempComp[funcName](tempComp, ...)
		end
	end
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New(self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function M:getComponents(compName)
	local comp
	local len = #self._compList

	if len > 0 then
		comp = self[compName]
	end

	return comp
end

function M:getIsShow()
	return self._show
end

function M:setVisible(show)
	goutil.setActive(self:getMainGO(), show)
end

function M:getMainGO()
	return self.mainGO
end

function M:getPointId()
	local elementId = self:getElementId()
	local cfg = elementId and MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId) or nil
	local pointId = cfg and cfg.interactPoint or nil

	if not pointId then
		printError(string.format("could not fond element[%s] pointId", elementId))
	end

	return pointId
end

function M:setElementId(elementId)
	self._elementId = elementId
end

function M:getElementId()
	return self._elementId
end

function M:onClickElement()
	return
end

return M
