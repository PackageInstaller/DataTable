-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/facade/TeamMainViewFacade.lua

module("logic.extensions.team.facade.TeamMainViewFacade", package.seeall)

local TeamMainViewFacade = class("TeamMainViewFacade", BaseFacade)

function TeamMainViewFacade:ctor()
	self._teamMainView = false
end

function TeamMainViewFacade:registerView(view)
	self._teamMainView = view
end

function TeamMainViewFacade:unregisterView()
	self._teamMainView = false
end

function TeamMainViewFacade:updateTeamInfo(index, heroId, unit)
	if not self:checkView() then
		return
	end

	self._teamMainView:updateUnitList(index, unit)
	self._teamMainView:_updateRolesInfo(index, heroId)
end

function TeamMainViewFacade:updateBottomInfo(index, heroId)
	self._teamMainView:_updateBottomInfo(index, heroId)
end

function TeamMainViewFacade:setPosByIndex(unit, index)
	if not self:checkView() then
		return
	end

	self._teamMainView:setPosByIndex(unit, index)
end

function TeamMainViewFacade:cancelSelectedCharacter()
	if not self:checkView() then
		return
	end

	self._teamMainView:cancelSelectedCharacter()
end

function TeamMainViewFacade:checkView()
	if not self._teamMainView then
		if enableErrorLog then
			printError("TeamMainViewFacade::need to register view first!")
		end

		return false
	end

	return true
end

function TeamMainViewFacade:getUnitByIndex(index)
	if not self:checkView() then
		return
	end

	return self._teamMainView:getUnitByIndex(index)
end

function TeamMainViewFacade:getIndexByHitGO(hitObjct)
	if not hitObjct then
		return false
	end

	local scene = SceneMgr.instance:getScene(SceneType.Team)
	local posList = scene.stage:getPosList()
	local curPosName = hitObjct.name
	local index = false

	for _, v in pairs(posList) do
		if v.name == curPosName then
			local lastIndeStr = string.sub(curPosName, -1)

			index = tonumber(lastIndeStr)

			break
		end
	end

	return index
end

function TeamMainViewFacade:getIndexByParent(hitObjct)
	if not hitObjct then
		return false
	end

	local scene = SceneMgr.instance:getScene(SceneType.Team)
	local posList = scene.stage:getPosList()
	local curPosName = hitObjct.transform.parent.name
	local curIndex = string.sub(curPosName, -1)
	local index = false

	for _, v in pairs(posList) do
		local tmpIndex = string.sub(v.name, -1)

		if tmpIndex == curIndex then
			index = curIndex

			break
		end
	end

	return index
end

function TeamMainViewFacade:getIndexByCell(hitObjct)
	if not hitObjct then
		return false
	end

	local scene = SceneMgr.instance:getScene(SceneType.Team)
	local posList = scene.stage:getPosList()
	local curPosName = hitObjct.name
	local curIndex = string.sub(curPosName, -1)
	local index = false

	for _, v in pairs(posList) do
		local tmpIndex = string.sub(v.name, -1)

		if tmpIndex == curIndex then
			index = curIndex

			break
		end
	end

	return index
end

function TeamMainViewFacade:setHighlight(index, colorString)
	if not self:checkView() then
		return
	end

	return self._teamMainView:setHighlight(index, colorString)
end

function TeamMainViewFacade:setCampInfo(index, name)
	if not self:checkView() then
		return
	end

	return self._teamMainView:setCampInfo(index, name)
end

TeamMainViewFacade.instance = TeamMainViewFacade.New()

return TeamMainViewFacade
