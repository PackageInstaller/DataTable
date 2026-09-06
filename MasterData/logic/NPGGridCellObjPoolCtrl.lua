-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/ui/NPGGridCellObjPoolCtrl.lua

module("logic.extensions.playmusic.view.NPGGridCellObjPoolCtrl", package.seeall)

local NPGGridCellObjPoolCtrl = class("NPGGridCellObjPoolCtrl")

function NPGGridCellObjPoolCtrl:ctor(go, goPoolRoot)
	self._go = go
	self._goPoolRoot = goPoolRoot
	self._compPool = self:_creatGridCellCompPool()
	self._goPool = self:_creatGridCellGoPool()
end

function NPGGridCellObjPoolCtrl:clear()
	self._compPool:clear()
	self._goPool:clear()
end

function NPGGridCellObjPoolCtrl:destroy()
	self._compPool = nil
	self._goPool = nil
end

function NPGGridCellObjPoolCtrl:fetchGridCell()
	local cell = self:_fetchGridCellComp()
	local mainGo = self:_fetchGridCellGo()

	cell:onInit(mainGo)

	return cell
end

function NPGGridCellObjPoolCtrl:returnGridCell(gridCell)
	local mainGo = gridCell:getGameObject()

	self:_returnGridCellComp(gridCell)
	self:_returnGridCellGo(mainGo)
end

function NPGGridCellObjPoolCtrl:_fetchGridCellComp()
	return self._compPool:fetchObject()
end

function NPGGridCellObjPoolCtrl:_returnGridCellComp(gridCell)
	self._compPool:returnObject(gridCell)
end

function NPGGridCellObjPoolCtrl:_creatGridCellCompPool()
	local comp = NPGGridCell

	local function createFunc()
		return comp.New()
	end

	local function disposeFunc(comp)
		comp:onDispose()
	end

	local function resetFunc(comp)
		comp:onReset()
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function NPGGridCellObjPoolCtrl:_fetchGridCellGo()
	return self._goPool:fetchObject()
end

function NPGGridCellObjPoolCtrl:_returnGridCellGo(go)
	self._goPool:returnObject(go)
end

function NPGGridCellObjPoolCtrl:_creatGridCellGoPool()
	local function createFunc()
		return goutil.clone(self._go)
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		goutil.addChildToParent(go, self._goPoolRoot)
		GameUtil.SetActive(go, false)
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

return NPGGridCellObjPoolCtrl
