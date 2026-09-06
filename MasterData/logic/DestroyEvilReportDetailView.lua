-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilReportDetailView.lua

module("logic.extensions.destroyevil.view.DestroyEvilReportDetailView", package.seeall)

local DestroyEvilReportDetailView = class("DestroyEvilReportDetailView", ViewComponent)

function DestroyEvilReportDetailView:buildUI()
	DestroyEvilReportDetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._petCon = self:getGo("petCol/mask/petCon")
	self._uIChangePetStage = goutil.findChildComponent(self.mainGO, "petCol/stage", "UIImageSpriteChange")
	self._txtPetName = self:getTxt("petCol/name/txtName")
	self._txtLevel = self:getTxt("petCol/level/txtLevel")
	self._txtStar = self:getTxt("petCol/star/txtStar")
	self._emptyGo = self:getGo("noData")
	self._tabelView = self:getGo("listCol/listview")
	self._tableCell = self:getGo("listCol/listItem")
	self._btnSure = self:getBtn("btnSure")

	local capacity = 20

	local function createFunc()
		return UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
	end

	local function disposeFunc(obj)
		UnityEngine.GameObject.Destroy(obj)
	end

	local function resetFunc(obj)
		obj.mainTexture = nil
	end

	self._objectPool = ObjectPool.New(capacity, createFunc, disposeFunc, resetFunc)
	self._usedMatList = {}
end

function DestroyEvilReportDetailView:destroyUI()
	DestroyEvilReportDetailView.super.destroyUI(self)
	self._objectPool:clear()
end

function DestroyEvilReportDetailView:bindEvents()
	DestroyEvilReportDetailView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function DestroyEvilReportDetailView:unbindEvents()
	DestroyEvilReportDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function DestroyEvilReportDetailView:onEnter()
	DestroyEvilReportDetailView.super.onEnter(self)
	self:_returnMats()

	self._tabScroll = ScrollerList.create(self._tabelView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local params = self:getOpenParam()

	self._activityId = params[1]

	local data = params[2]

	self._actCfg = DestroyEvilConfig.instance:getActivityCfg(self._activityId)

	self:_refreshPetInfo(data)
	self._tabScroll:reloadData(data.playerInfoList)
end

function DestroyEvilReportDetailView:onExit()
	DestroyEvilReportDetailView.super.onExit(self)
	self:_returnMats()
	self:_resetRoleModel()
end

function DestroyEvilReportDetailView:_refreshPetInfo(data)
	local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, data.monsterId)
	local cfgMaster = DestroyEvilConfig.instance:getMaster(cfgMonster.creepsMasterId)
	local cfgCreeps = DestroyEvilConfig.instance:getCreeps(cfgMonster.creepsMasterId)
	local targetPosId = cfgCreeps[1].posId
	local cfgTarget = cfgCreeps[1]

	for i, v in ipairs(cfgCreeps) do
		if targetPosId > v.posId then
			targetPosId = v.posId
			cfgTarget = v
		end
	end

	local res = {}

	for i, v in ipairs(cfgCreeps) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(v.extproperties) or {}

		res = AttrMo.addSameAttrs(attrs, res)
	end

	self._bossMaxHp = checknumber(res[FightingPowerFormula.instance:getAttrTypeByName("生命")])

	self._uIChangePetStage:SetState(1)

	self._txtStar.text = cfgMonster.star
	self._txtPetName.text = "Lv." .. checknumber(cfgMonster.level)

	self:_showRoleModel(cfgTarget.raceId)
end

function DestroyEvilReportDetailView:_showRoleModel(raceId)
	local curFaceId = raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._petCon, scale, function(go)
		local sgArray = go:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic))

		if sgArray then
			for i = 0, sgArray.Length - 1 do
				local sg = sgArray[i]

				if not goutil.isNil(sg) then
					local _tempMat = self._objectPool:fetchObject()

					_tempMat.mainTexture = sg.material.mainTexture
					sg.material = _tempMat

					table.insert(self._usedMatList, _tempMat)
				end
			end
		end
	end, true, x, y)
end

function DestroyEvilReportDetailView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DestroyEvilReportDetailView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "rank/txtRank")
	local imgChangeRank = goutil.findChildComponent(go, "rank", "UIImageSpriteChange")
	local imgHeadIcon = goutil.findChild(go, "headGo")
	local sliderDamage = Framework.SliderAdapter.GetFrom(go, "barSli")
	local imgChangeStage = goutil.findChildComponent(go, "stage", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtPower = goutil.findChildTextComponent(go, "txtPower")

	txtRank.text = data.rank

	GameUtil.SetActive(imgChangeRank, data.rank <= 3 and data.rank > 0)
	GameUtil.SetActive(txtRank, true)

	if data.rank <= 3 and data.rank > 0 then
		imgChangeRank:SetState(data.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
	else
		GameUtil.SetActive(imgChangeRank, false)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgHeadIcon)
			end
		end)
	end

	if checknumber(data.damage) < self._bossMaxHp then
		sliderDamage:SetValue(checknumber(data.damage) / self._bossMaxHp)
	else
		sliderDamage:SetValue(1)
	end

	GameUtil.SetActive(imgChangeStage, false)

	if data.headInfo.userId == data.mvpPlayerId then
		GameUtil.SetActive(imgChangeStage, true)
		imgChangeStage:SetState(0)
	elseif data.headInfo.userId == RoleModel.instance:getUserId() then
		GameUtil.SetActive(imgChangeStage, true)
		imgChangeStage:SetState(1)
	end

	txtName.text = data.headInfo.userName
	txtPower.text = data.damage
end

function DestroyEvilReportDetailView:_clearCell(cell)
	local go = cell.gameObject
	local imgHeadIcon = goutil.findChild(go, "headGo")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)
end

function DestroyEvilReportDetailView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function DestroyEvilReportDetailView:_returnMats()
	if #self._usedMatList > 0 then
		for i, v in ipairs(self._usedMatList) do
			self._objectPool:returnObject(v)
		end

		table.clear(self._usedMatList)
	end
end

return DestroyEvilReportDetailView
