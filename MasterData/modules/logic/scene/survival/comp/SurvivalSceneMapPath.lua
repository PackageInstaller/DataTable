-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneMapPath.lua

module("modules.logic.scene.survival.comp.SurvivalSceneMapPath", package.seeall)

local SurvivalSceneMapPath = class("SurvivalSceneMapPath", BaseSceneComp)

SurvivalSceneMapPath.ResPaths = {
	line180 = "survival/transport/v2a8_survival_transport_b.prefab",
	tail = "survival/transport/v2a8_survival_transport_a.prefab",
	linePoint = "survival/transport/v2a8_survival_transport_e.prefab",
	line60 = "survival/transport/v2a8_survival_transport_c.prefab",
	line120 = "survival/transport/v2a8_survival_transport_d.prefab"
}

function SurvivalSceneMapPath:onScenePrepared(sceneId, levelId)
	self._sceneGo = self:getCurScene().level:getSceneGo()
	self._pathRoot = gohelper.create3d(self._sceneGo, "PathRoot")

	local trans = self._pathRoot.transform

	transformhelper.setLocalPos(trans, 0, 0.01, 0)

	self._curShowLines = {}
	self._pools = {}

	for k, v in pairs(SurvivalSceneMapPath.ResPaths) do
		self._pools[v] = {}
	end
end

function SurvivalSceneMapPath:setPathListShow(paths)
	TaskDispatcher.cancelTask(self.setPathListShow, self)
	self:clearCurLines()

	if paths then
		if not #paths then
			local len = 0

			if len >= 2 then
				for i = 1, len do
					local path, rotate = self:getPathAndRotate(paths[i - 1], paths[i], paths[i + 1])
					local obj = self:getObj(path, paths[i], rotate)

					table.insert(self._curShowLines, obj)
				end

				table.insert(self._curShowLines, self:getObj(SurvivalSceneMapPath.ResPaths.linePoint, paths[#paths], 0))

				local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
				local sceneMo = SurvivalMapModel.instance:getSceneMo()
				local cost = weekInfo:getAttr(SurvivalEnum.AttrType.MoveCost)
				local totalCost = 0

				for index, pos in ipairs(paths) do
					if index ~= len then
						local co = sceneMo:getBlockCoByPos(pos)

						totalCost = co and ((co.subType == SurvivalEnum.UnitSubType.Ice or co.subType == SurvivalEnum.UnitSubType.Morass and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Morass) == 0 or co.subType == SurvivalEnum.UnitSubType.Water and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Water) == 0) and totalCost + math.floor(cost * (1000 + co.preAttr) / 1000) or totalCost + cost) or totalCost + cost
					end
				end

				SurvivalMapModel.instance.showCostTime = totalCost
			else
				SurvivalMapModel.instance.showCostTime = 0
				paths = nil
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapCostTimeUpdate, paths)
		end
	end
end

function SurvivalSceneMapPath:getPathAndRotate(pos1, pos2, pos3)
	if not pos1 then
		local dir = SurvivalHelper.instance:getDir(pos2, pos3)

		return SurvivalSceneMapPath.ResPaths.tail, dir * 60
	elseif not pos3 then
		local dir = SurvivalHelper.instance:getDir(pos2, pos1)

		return SurvivalSceneMapPath.ResPaths.tail, dir * 60
	else
		local dir1 = SurvivalHelper.instance:getDir(pos2, pos1)
		local dir2 = SurvivalHelper.instance:getDir(pos2, pos3)
		local angle = (dir2 - dir1 + 6) % 6

		if angle == 3 then
			return SurvivalSceneMapPath.ResPaths.line180, dir1 * 60
		elseif angle == 2 then
			return SurvivalSceneMapPath.ResPaths.line120, dir1 * 60
		elseif angle == 1 then
			return SurvivalSceneMapPath.ResPaths.line60, dir1 * 60
		elseif angle == 4 then
			return SurvivalSceneMapPath.ResPaths.line120, dir2 * 60
		elseif angle == 5 then
			return SurvivalSceneMapPath.ResPaths.line60, dir2 * 60
		end
	end
end

function SurvivalSceneMapPath:getObj(path, pos, rotate)
	local go = table.remove(self._pools[path])

	if go then
		gohelper.setActive(go, true)
	else
		local res = SurvivalMapHelper.instance:getBlockRes(path)

		go = gohelper.clone(res, self._pathRoot)
	end

	local trans = go.transform
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)

	transformhelper.setLocalPos(trans, x, y, z)
	transformhelper.setLocalRotation(trans, 0, rotate + 90, 0)

	return {
		path = path,
		go = go
	}
end

function SurvivalSceneMapPath:returnObj(path, obj)
	table.insert(self._pools[path], obj)
	gohelper.setActive(obj, false)
end

function SurvivalSceneMapPath:clearCurLines()
	if not next(self._curShowLines) then
		return
	end

	for _, v in ipairs(self._curShowLines) do
		self:returnObj(v.path, v.go)
	end

	self._curShowLines = {}
end

function SurvivalSceneMapPath:setDelayHide()
	SurvivalMapModel.instance.showCostTime = 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapCostTimeUpdate)
	TaskDispatcher.runDelay(self.setPathListShow, self, 0.3)
end

function SurvivalSceneMapPath:onSceneClose()
	TaskDispatcher.cancelTask(self.setPathListShow, self)

	for k, v in pairs(self._pools) do
		for _, go in pairs(v) do
			gohelper.destroy(go)
		end
	end

	self._pools = {}

	for _, v in ipairs(self._curShowLines) do
		gohelper.destroy(v.go)
	end

	self._curShowLines = {}
end

return SurvivalSceneMapPath
