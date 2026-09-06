-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/view/OriginKingMoYanClgFmtView.lua

module("logic.extensions.originkingmoyanclg.view.OriginKingMoYanClgFmtView", package.seeall)

local OriginKingMoYanClgFmtView = class("OriginKingMoYanClgFmtView", ViewComponent)

function OriginKingMoYanClgFmtView:ctor()
	OriginKingMoYanClgFmtView.super.ctor(self)
end

function OriginKingMoYanClgFmtView:unbindEvents()
	OriginKingMoYanClgFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)
end

function OriginKingMoYanClgFmtView:bindEvents()
	OriginKingMoYanClgFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)
end

function OriginKingMoYanClgFmtView:buildUI()
	OriginKingMoYanClgFmtView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._txtDesc = self:getTxt("moveNode/layout/txtDesc")
	self._txtExt = self:getTxt("moveNode/layout/txtExt")
	self._cellMap = {}

	local fmtGo = self:getGo("moveNode/layout/fmt")

	for i = 1, 9 do
		local cell = {}

		cell.go = goutil.findChild(fmtGo, "cell_" .. i)
		cell.con = goutil.findChild(cell.go, "con")
		cell.conTag = goutil.findChild(cell.go, "tag")
		cell.emptyTag = goutil.findChild(fmtGo, string.format("bg/cell_%d/tag", i))
		cell.bgChange = cell.emptyTag:GetComponent(ComponentType.UIImageSpriteChange)
		cell.conTagChange = goutil.findChildComponent(cell.conTag, "img", ComponentType.UIImageSpriteChange)
		self._cellMap[i] = cell
	end
end

function OriginKingMoYanClgFmtView:onExit()
	OriginKingMoYanClgFmtView.super.onExit(self)

	for i = 1, 9 do
		GameUtil.SetActive(self._cellMap[i].go, false)
		MaterialMgr.resetAll(self._cellMap[i].con)
	end
end

function OriginKingMoYanClgFmtView:onEnterFinished()
	OriginKingMoYanClgFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._isPopupState = true

	GameUtil.SetActive(self._btnHide, true)
	GameUtil.setAnchoredPos(self._moveNode, -110, 80)
	GameUtil.setLocalRotation(self._arrowRectTrans, 0, 0, 0)

	local stageCfg = OriginKingMoYanClgConfig.instance:getStageCfg(self._fmtMo.activityId, self._fmtMo.floorId, self._fmtMo.stageId)

	self._txtExt.text = stageCfg.ruleDesc

	local masterList = OriginKingMoYanClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)
	local index = 1

	for i = 1, 9 do
		GameUtil.SetActive(self._cellMap[i].go, false)
		MaterialMgr.resetAll(self._cellMap[i].con)
	end

	for i, v in ipairs(masterList) do
		if self._cellMap[v.posId] then
			GameUtil.SetActive(self._cellMap[v.posId].go, true)
			MaterialMgr.setIcon(self._cellMap[v.posId].con, MatType.Pet, v.raceId)
		end
	end

	local flowerBuffList = OriginKingMoYanClgConfig.instance:getBuffCfgWithType(self._fmtMo.activityId, 1)
	local activeFlowerBuffCfg

	for i, v in ipairs(flowerBuffList) do
		if self._fmtMo.flowerCount >= v.itemCount then
			activeFlowerBuffCfg = v
		end
	end

	local content1

	for i = 1, 9 do
		GameUtil.SetActive(self._cellMap[i].conTag, false)
		GameUtil.SetActive(self._cellMap[i].emptyTag, false)
		self._cellMap[i].bgChange:SetState(0)
		self._cellMap[i].conTagChange:SetState(0)
	end

	local enemyFormation = MissionModel.instance:getEnemyFormations()
	local zdlList = {}

	for i = 1, 9 do
		if enemyFormation and enemyFormation[i] and self._cellMap[i] then
			local zdl = enemyFormation[i]:getFightingPower()

			table.insert(zdlList, {
				pos = i,
				zdl = zdl
			})
		end
	end

	table.sort(zdlList, function(a, b)
		if a.zdl ~= b.zdl then
			return a.zdl > b.zdl
		else
			return a.pos < b.pos
		end
	end)

	if activeFlowerBuffCfg then
		content1 = index .. "." .. activeFlowerBuffCfg.desc

		if activeFlowerBuffCfg.unitPos then
			if not activeFlowerBuffCfg.unitPos[1] then
				do
					local maxNum = 1

					for i = 1, maxNum do
						if zdlList[i] then
							GameUtil.SetActive(self._cellMap[zdlList[i].pos].conTag, true)
							GameUtil.SetActive(self._cellMap[zdlList[i].pos].emptyTag, true)
						end
					end

					index = index + 1
				end

				local fireBuffList = OriginKingMoYanClgConfig.instance:getBuffCfgWithType(self._fmtMo.activityId, 2)
				local activeFireBuffCfg

				for i, v in ipairs(fireBuffList) do
					if self._fmtMo.fireCount >= v.itemCount then
						activeFireBuffCfg = v
					end
				end

				local content2

				if activeFireBuffCfg then
					content2 = index .. "." .. activeFireBuffCfg.desc
					index = index + 1
				end

				local unitBuffList = OriginKingMoYanClgConfig.instance:getBuffCfgWithType(self._fmtMo.activityId, 3)
				local activeUnitBuffCfg

				for i, v in ipairs(unitBuffList) do
					if self._fmtMo.unitCount >= v.itemCount then
						activeUnitBuffCfg = v
					end
				end

				local content3

				if activeUnitBuffCfg then
					content3 = index .. "." .. activeUnitBuffCfg.desc

					if activeUnitBuffCfg.unitPos then
						if not activeUnitBuffCfg.unitPos[1] then
							do
								local maxNum = 1

								for i = 1, maxNum do
									if zdlList[i] then
										self._cellMap[zdlList[i].pos].bgChange:SetState(1)
										self._cellMap[zdlList[i].pos].conTagChange:SetState(1)
									end
								end
							end

							local content = table.concat({
								content1,
								content2,
								content3
							}, "\n")

							if string.nilorempty(content) then
								content = lang("未激活任意效果")
							end

							self._txtDesc.text = content
						end
					end
				end
			end
		end
	end
end

function OriginKingMoYanClgFmtView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function OriginKingMoYanClgFmtView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(400, 80, 0), Vector3.New(-110, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

return OriginKingMoYanClgFmtView
