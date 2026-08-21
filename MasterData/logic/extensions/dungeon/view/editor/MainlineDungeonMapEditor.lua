-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/editor/MainlineDungeonMapEditor.lua

module("logic.extensions.dungeon.view.editor.MainlineDungeonMapEditor", package.seeall)

local M = class("MainlineDungeonMapEditor", SimpleCellComponent)

function M:buildUI()
	self._dungeonGoList = {}
	self._dungeonCellList = {}

	for i = 0, self._go.transform.childCount - 1 do
		local tmpGo = self._go.transform:GetChild(i).gameObject
		local index = self:getDungeonIndexByName(tmpGo.name, "level_item_")

		if index then
			self._dungeonGoList[index] = tmpGo
			self._dungeonCellList[index] = Astral.SimpleLuaComponentContainer.Add(tmpGo, MainlineDungeonEditorCell)
		end
	end
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:bindDispatcherEvent()
	return
end

function M:unbindDispatcherEvent()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_setData(chapterMO)
	self._chapterMO = chapterMO
end

function M:_refreshUI()
	local dungeonIds = self._chapterMO:getDungeonIds()

	for index, cell in pairs(self._dungeonCellList) do
		local isUnlock = true

		cell:setData(dungeonIds[index], isUnlock)
	end
end

function M:clear()
	goutil.destroy(self._go)
end

function M:setVisible(active)
	goutil.setActive(self._go, active)
end

function M:getMaxPosX()
	local maxPosX = 0

	for i = 0, self._go.transform.childCount - 1 do
		local posX = self._go.transform:GetChild(i).anchoredPosition.x

		if maxPosX < posX then
			maxPosX = posX
		end
	end

	return maxPosX
end

function M:createDungeon(goDungeon, index, posX, posY)
	goutil.addChildToParent(goDungeon, self._go.transform)
	Astral.TransformUtil.SetAnchoredPos(goDungeon.transform, posX, posY)

	self._dungeonGoList[index] = goDungeon
	self._dungeonCellList[index] = Astral.SimpleLuaComponentContainer.Add(goDungeon, MainlineDungeonEditorCell)
end

function M:deleteDungeon(dungeonCell)
	goutil.destroy(dungeonCell:getMainGo())
end

function M:save(path, callBack, callBackObj)
	for _, cell in pairs(self._dungeonCellList) do
		cell:exitEditMode()
	end

	UnityEngine.GameObject.Destroy(self._container)
	settimer(0, function()
		local go, result = PrefabUtilityHelper.SaveAsPrefabAsset(self._go, path, true)

		if result == true then
			FloatWordMgr.instance:show(lang("保存成功！"))
		else
			FloatWordMgr.instance:show(lang("保存失败！！"))
		end

		callBack(callBackObj, result, go)
	end, nil, false)
end

function M:adjustLine(leftOffset, rightOffset)
	for index, id in ipairs(self._chapterMO:getNormalDungeonIds()) do
		local dungeonCell = self._dungeonCellList[index]

		if index > 1 then
			local preCell = self._dungeonCellList[index - 1]
			local leftPos = preCell:getPos() + leftOffset
			local rightPos = dungeonCell:getPos() + rightOffset

			dungeonCell:setLinePortPos(leftPos, rightPos, rightOffset)
			dungeonCell:setlineVisible(true)
		else
			dungeonCell:setlineVisible(false)
		end
	end
end

function M:setDifficulty(difficulty)
	return
end

function M:getNodeByIndex(index)
	return self._dungeonCellList[index].mainGO
end

function M:getNodeInfoByIndex(index)
	return self._dungeonCellList[index] or false
end

function M:getNodeAnchoredPosX(index)
	return self._dungeonGoList[index].transform.anchoredPosition.x
end

function M:setSelectedDungeon(dungeonId)
	for idx, cell in pairs(self._dungeonCellList) do
		cell:setSelected(dungeonId == cell:getDungeonId())
	end
end

function M:getDungeonIndexByName(name, splitStr)
	local stringParam = string.split(name, splitStr)

	stringParam = string.split(stringParam[2], "_")

	if #stringParam == 1 then
		return tonumber(stringParam[1])
	elseif #stringParam == 3 then
		return tonumber(stringParam[2]) * 100 + tonumber(stringParam[3])
	else
		printError("节点命名格式不对:", name)
	end

	return nil
end

return M
