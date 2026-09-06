-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyamapView.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyamapView", package.seeall)

local MiraclenuoyamapView = class("MiraclenuoyamapView", ViewComponent)

function MiraclenuoyamapView:ctor()
	MiraclenuoyamapView.super.ctor(self)
end

function MiraclenuoyamapView:unbindEvents()
	MiraclenuoyamapView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function MiraclenuoyamapView:bindEvents()
	MiraclenuoyamapView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function MiraclenuoyamapView:buildUI()
	MiraclenuoyamapView.super.buildUI(self)

	self._con = self:getGo("con")
	self._cloudRoot = self:getGo("cloudRoot")
	self._cloudCell = self:getGo("cloudCell")
	self._item = self:getGo("item")
	self._btnJump1 = self:getGo("down/btnJump1")
	self._btnJump2 = self:getGo("down/btnJump2")
	self._head = self:getGo("down/head")
	self._txtDesc = self:getTxt("down/txtDesc")
	self._txtHp = self:getTxt("down/txtHp")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtProgress = self:getTxt("txtProgress/txt")
	self._locHead = self:getGo("locHead")
	self._btnTip = self:getGo("leftTop/btnTip")

	GameUtil.SetActive(self._locHead, false)
	GameUtil.SetActive(self._item, false)
end

function MiraclenuoyamapView:onExit()
	MiraclenuoyamapView.super.onExit(self)
	GameUtil.clearCells(self._cloudRoot, self._clearCloudCell, self)
end

function MiraclenuoyamapView:onEnter()
	MiraclenuoyamapView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local isInTime = MiracleNuoyaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._activityType = MiracleNuoyaController.instance:getActivityType()
	self._actCfg = MiracleNuoyaConfig.instance:getActivityCfgById(self._activityId)
	self._mapCfg = MiracleNuoyaConfig.instance:getMapCfgById(self._activityId)
	self._passedBlockIdList = {}
	self._lastPassedBlockId = 0
	self._lightBlockIdDic = {}
	self._passBlockIdDic = {}

	self:_initView()
	self.addGEvent(self, GlobalNotify.MiracleNuoYaInfoUpdate, self._refreshUI, self)
	MiracleNuoyaController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
end

function MiraclenuoyamapView:_initView()
	self._itemMap = {}

	goutil.clearChildren(self._con)

	for k, v in pairs(self._mapCfg) do
		if v.blockId == 0 then
			-- block empty
		elseif not v.pos then
			local pos = {}
			local item = goutil.clone(self._item, "item_" .. v.blockId)

			goutil.addChildToParent(item, self._con)
			GameUtil.SetActive(item, true)

			local pass = goutil.findChild(item, "imgPass")

			GameUtil.SetActive(pass, false)

			local goDesc = goutil.findChild(item, "txtDesc")

			GameUtil.SetActive(goDesc, true)

			local txtDesc = goutil.findChildTextComponent(item, "txtDesc/txt")

			txtDesc.text = "未开启"

			GameUtil.setAnchoredPos(item, checknumber(pos[1]), checknumber(pos[2]))
			GameUtil.addClickHandler(item, GameUtil.handler(self._onClickItem, self, v))

			self._itemMap[v.blockId] = item
		end
	end

	self._myLocHead = goutil.clone(self._locHead, "myLocHead")

	goutil.addChildToParent(self._myLocHead, self._con)
	GameUtil.SetActive(self._myLocHead, true)

	local head = goutil.findChild(self._myLocHead, "img")

	HeadItemController.instance:setMyHeadCellWithoutVip(head)
	HeadItemController.instance:setMyHeadCellWithoutVip(self._head)
end

function MiraclenuoyamapView:_refreshUI()
	local info = MiracleNuoyaModel.instance:getInfo(self._activityId) or {}

	if not info.extremeClgInfo then
		local extremeClgInfo = {}

		self._passedBlockIdList = extremeClgInfo.extremeClgPassedBlockId or {}
		self._lastPassedBlockId = checknumber(extremeClgInfo.extremeClgLastPassedBlockId)
		self._supportPetLeftHpPercent = checknumber(extremeClgInfo.extremeClgSupportPetLeftHpPercent)
		self._passBlockIdDic = {}

		for i, blockId in ipairs(self._passedBlockIdList) do
			self._passBlockIdDic[blockId] = true
		end

		self._lightBlockIdDic = {}

		for i, data in pairs(self._mapCfg) do
			local blockId = data.blockId

			if self._passBlockIdDic[blockId] == true then
				self._lightBlockIdDic[blockId] = true

				local blockCfg = MiracleNuoyaConfig.instance:getMapBlockCfgById(self._activityId, blockId) or {}

				if not blockCfg.neighbours then
					local neighbours = {}

					for i, id in ipairs(neighbours) do
						self._lightBlockIdDic[id] = true
					end
				end
			end
		end

		local darkBlockIdList = {}

		for _, data in pairs(self._mapCfg) do
			local blockId = data.blockId

			if blockId > 0 and not self._lightBlockIdDic[blockId] then
				table.insert(darkBlockIdList, blockId)
			end
		end

		local curBlockCfg = MiracleNuoyaConfig.instance:getMapBlockCfgById(self._activityId, self._lastPassedBlockId) or {}

		GameUtil.setAnchoredPos(self._myLocHead, checknumber(curBlockCfg.pos[1]), checknumber(curBlockCfg.pos[2]))

		self._txtHp.text = self._supportPetLeftHpPercent .. "%"

		for blockId, item in pairs(self._itemMap) do
			local goDesc = goutil.findChild(item, "txtDesc")
			local txtDesc = goutil.findChildTextComponent(item, "txtDesc/txt")

			GameUtil.SetActive(goDesc, true)

			txtDesc.text = "未开启"
		end

		for _, data in pairs(self._mapCfg) do
			local blockId = data.blockId
			local item = self._itemMap[blockId]
			local isPass = self._passBlockIdDic[blockId] == true
			local blockData = MiracleNuoyaConfig.instance:getMapBlockCfgById(self._activityId, blockId) or {}

			if item then
				local pass = goutil.findChild(item, "imgPass")
				local con = goutil.findChild(item, "pet/mask/con")

				GameUtil.SetActive(pass, isPass)

				if not blockData.creepsMasterId then
					local creepsMasterId = 0
					local creepsCfg = MiracleNuoyaConfig.instance:getCreepsCfgById(creepsMasterId)
					local creepsData = creepsCfg and creepsCfg[1]
					local skinId = checknumber(creepsData and creepsData.faceId)

					if skinId <= 0 then
						skinId = checknumber(creepsData.raceId)
					end

					local modelCo = CharacterConfig.instance:getModelCo(skinId)

					if modelCo then
						uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
					else
						uGuiUtil.clearImage(con)
					end
				end
			end

			if isPass then
				if not blockData.neighbours then
					local neighbours = {}

					for i, id in ipairs(neighbours) do
						self:_showItemOpen(id)
					end
				end
			end
		end

		for _, blockId in pairs(self._lightBlockIdDic) do
			self:_showItemOpen(blockId)
		end

		local max = #self._mapCfg
		local cur = #self._passedBlockIdList - 1

		self._txtProgress.text = string.format("关卡进度：%s/%s", cur, max)

		GameUtil.updateCellsList(self._cloudRoot, self._cloudCell, darkBlockIdList, self._updateCloudCell, self)

		local maxPercent = 0
		local fitData
		local cfg = MiracleNuoyaConfig.instance:getBuffListCfg(self._activityId)

		for index, data in pairs(cfg) do
			local leftHpPercent = data.leftHpPercent

			if leftHpPercent <= self._supportPetLeftHpPercent and maxPercent <= leftHpPercent then
				maxPercent = leftHpPercent
				fitData = data
			end
		end

		if fitData then
			self._txtDesc.text = fitData.buffDesc or "无"
		end
	end
end

function MiraclenuoyamapView:_updateCloudCell(mainGo, blockId, index)
	local imgCloud = goutil.findChild(mainGo, "imgCloud")
	local imgCloudComp = imgCloud:GetComponent(ComponentType.RawImage)
	local data = MiracleNuoyaConfig.instance:getMapBlockCfgById(self._activityId, blockId)
	local isHaveCloud = data and data.cloudPos ~= nil

	if isHaveCloud then
		if not data.cloudPos then
			local cloudPos = {}
			local x, y = checknumber(cloudPos[1]), checknumber(cloudPos[2])

			if not cloudPos[3] then
				if not cloudPos[4] then
					local alpha = 1

					GameUtil.setLocalPos(mainGo, x, y, 0)
					GameUtil.setLocalScale(mainGo, cloudPos[3])

					local color = imgCloudComp.color

					imgCloudComp.color = Color.New(color.r, color.g, color.b, alpha)
				end
			end
		end
	end

	GameUtil.SetActive(imgCloud, isHaveCloud)
end

function MiraclenuoyamapView:_clearCloudCell(mainGo)
	return
end

function MiraclenuoyamapView:_showItemOpen(blockId)
	local item = self._itemMap[blockId]

	if item then
		local goDesc = goutil.findChild(item, "txtDesc")
		local txtDesc = goutil.findChildTextComponent(item, "txtDesc/txt")

		GameUtil.SetActive(goDesc, false)
	end
end

function MiraclenuoyamapView:_onClickItem(cfg)
	if not self:_checkPassAoqiGodProcessResult() then
		return
	end

	local blockId = cfg.blockId
	local info = MiracleNuoyaModel.instance:getInfo(self._activityId) or {}

	if not info.extremeClgInfo then
		if self._passBlockIdDic[blockId] then
			TipsFacade.instance:openCommonTips("该关卡已通关")

			return
		end

		if self._supportPetLeftHpPercent <= 0 then
			TipsFacade.instance:openCommonTips("奥奇剩余血量为0，不可继续挑战")

			return
		end

		if self._lightBlockIdDic[blockId] then
			MiracleNuoyaController.instance:openExtFmtView(self._activityId, blockId)
		else
			TipsFacade.instance:openCommonTips("仅可挑战已通关关卡的相邻关卡")
		end
	end
end

function MiraclenuoyamapView:_onClickReset()
	if not self:_checkPassAoqiGodProcessResult() then
		return
	end

	if #self._passedBlockIdList <= 1 then
		FloatWordMgr.instance:show("尚未通关任何关卡，无需重置")

		return
	end

	if #self._passedBlockIdList >= #self._mapCfg + 1 then
		FloatWordMgr.instance:show("已通关关卡并获得奖励，无需重置")

		return
	end

	local content = "是否重置所有关卡挑战，奥奇回复为100%血量"

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		MiracleNuoyaController.instance:sendResetExtre(self._activityId)
	end)
end

function MiraclenuoyamapView:_onClickInfo()
	UIStateManager.instance:push(ViewName.MiraclenuoyabuffView, self._activityId)
end

function MiraclenuoyamapView:_onClickBtnTip()
	local ruleKey = self._actCfg.ruleKeyExt

	TipsFacade.instance:openRulesView(ruleKey)
end

function MiraclenuoyamapView:_checkPassAoqiGodProcessResult()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return false
		end
	end

	return true
end

return MiraclenuoyamapView
