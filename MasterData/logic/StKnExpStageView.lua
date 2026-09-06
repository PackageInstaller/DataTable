-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpStageView.lua

module("logic.extensions.stknexp.view.StKnExpStageView", package.seeall)

local StKnExpStageView = class("StKnExpStageView", ViewComponent)

function StKnExpStageView:ctor()
	StKnExpStageView.super.ctor(self)

	self._prizeScrollListDic = {}
	self._stageLoaders = {}
end

function StKnExpStageView:buildUI()
	StKnExpStageView.super.buildUI(self)

	self._btnRank = self:getGo("btnCol/btnRank")
	self._btnMining = self:getGo("btnCol/btnMining")
	self._btnBuff = self:getGo("btnCol/btnBuff")
	self._blackMask = self:getGo("blackMask")

	GameUtil.SetActive(self._blackMask, true)

	local stageScrView = self:getGo("stageCol/scrView")
	local stageContent = self:getGo("stageCol/scrView/Viewport/Content")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._rootStageScrCell = self:getGo("stageCol/scrCell/root")
	self._rootPosVec = GameUtil.getLocalPos(self._rootStageScrCell)
	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._tableview = stageScrView:GetComponent("UITableview")
	self._tableview.useAnchorPosition = true
	self._infoCol = self:getGo("infoCol")
	self._infoColCanvas = self._infoCol:GetComponent(ComponentType.Canvas)
	self._txtStage = self:getTxt("infoCol/txtStage")
	self._imgPass = self:getGo("infoCol/fmt/imgPass")
	self._fmtView = self:getGo("infoCol/fmt/fmtView")
	self._txtBuffDesc = self:getTxt("infoCol/txtBuffDesc")
	self._btnEnter = self:getGo("infoCol/btnEnter")
	self._nearBg1 = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_UIImage)
	self._middleBg2 = self:getGo("dynamicBg/middleBg2"):GetComponent(goutil.Type_UIImage)
	self._farBg3 = self:getGo("dynamicBg/farBg3"):GetComponent(goutil.Type_UIImage)
	self._imgGos = {
		self._nearBg1.gameObject,
		self._middleBg2.gameObject,
		self._farBg3.gameObject
	}
	self._nearImageBigBG = self._nearBg1.gameObject:GetComponent("ImageBigBG")
	self._middleImageBigBG = self._middleBg2.gameObject:GetComponent("ImageBigBG")
	self._farImageBigBG = self._farBg3.gameObject:GetComponent("ImageBigBG")
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(self._tableview.gameObject)
	self._scrollRectTransform = self._tableview.gameObject:GetComponent(goutil.Type_RectTransform)
	self._contentRectTransform = stageContent:GetComponent(goutil.Type_RectTransform)
	self._nearBgRectTrans = self._nearBg1:GetComponent(goutil.Type_RectTransform)
end

function StKnExpStageView:bindEvents()
	StKnExpStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnMining, self._onClickBtnMining, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
end

function StKnExpStageView:unbindEvents()
	StKnExpStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnMining)
	GameUtil.rmClickHandler(self._btnBuff)
	self._scrollAdapter:RemoveOnValueChanged()
end

function StKnExpStageView:onEnter()
	StKnExpStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)
	self._actData = StKnExpConfig.instance:getActData(self._activityId)
	self._zoneData = StKnExpConfig.instance:getZoneData(self._activityId, self._zoneId)
	self._curStageId = 0
	self._infoColCanvas.overrideSorting = true
	self._infoColCanvas.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 2

	self:_loadDynamicBg()
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function StKnExpStageView:onExit()
	StKnExpStageView.super.onExit(self)

	self._infoColCanvas.overrideSorting = false

	self:_removeDynamicBg()
	self:_onClearStageCol()
	self:_onClearInfoCol()
end

function StKnExpStageView:_loadDynamicBg()
	local fields = StKnExpEnum.StageBgFields

	for idx, field in ipairs(fields) do
		local bgName = self._zoneData[field]

		if not string.nilorempty(bgName) then
			local url = string.format("ui/bigbg/%s.png", bgName)
			local imgGo = self._imgGos[idx]

			uGuiUtil.setSpriteToImage(imgGo, uGuiUtil.SpriteType.BigBg, url)
		end
	end

	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
end

function StKnExpStageView:_removeDynamicBg()
	for k, v in pairs(self._imgGos) do
		uGuiUtil.clearImage(v)
	end

	self._nearBg1.material = nil
	self._middleBg2.material = nil

	goutil.destroy(self._nearBgMat1)
	goutil.destroy(self._middleBgMat2)

	self._nearBgMat1 = nil
	self._middleBgMat2 = nil
end

function StKnExpStageView:_onScrollValueChanged(vec2)
	if not self._nearBgMat1 or not self._middleBgMat2 then
		return
	end

	if goutil.getWidth(self._contentRectTransform) < goutil.getWidth(self._scrollRectTransform) then
		self._nearBgMat1:SetTextureOffset("_MainTex", Vector2.zero)
		self._middleBgMat2:SetTextureOffset("_MainTex", Vector2.zero)
	else
		self._nearBgWidth = goutil.getWidth(self._nearBgRectTrans)

		local percentPos = self._contentRectTransform.anchoredPosition.x / self._nearBgWidth

		percentPos = -1 * percentPos
		vec2.x = percentPos
		vec2.y = 0

		self._nearBgMat1:SetTextureOffset("_MainTex", vec2)
		self._middleBgMat2:SetTextureOffset("_MainTex", vec2 * 0.8)
	end
end

function StKnExpStageView:_onUpdate()
	self._curStageId = self._subMo:getCurStageId(self._zoneId) + 1

	self:_onUpdateStageColUI()
	self:_onUpdateInfoColUI()
end

function StKnExpStageView:_onUpdateStageColUI()
	local cfg = StKnExpConfig.instance:getStageCfg(self._activityId, self._zoneId) or {}

	self._stageScrollerList:reloadData(cfg)

	local index = 1

	for stageId, data in ipairs(cfg) do
		index = stageId

		if not self._subMo:isPassStage(self._zoneId, stageId) then
			break
		end
	end

	self._stageScrollerList:MoveCellToCenter(index - 1)
end

function StKnExpStageView:_onClearStageCol()
	self._stageScrollerList:dispose()
end

function StKnExpStageView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local isUnlock = self._subMo:isUnlockStage(self._zoneId, stageId)
	local isPass = self._subMo:isPassStage(self._zoneId, stageId)
	local isSelelcted = self._curStageId == stageId
	local state = 0

	if isSelelcted then
		state = 3
	elseif isPass then
		state = 2
	elseif isUnlock then
		state = 1
	end

	local index = cell.index
	local mainGo = cell.gameObject
	local canvas = mainGo:GetComponent(ComponentType.Canvas)
	local root = goutil.findChild(mainGo, "root")
	local txtName = goutil.findChildTextComponent(root, "name/txt")
	local role = goutil.findChild(root, "role")
	local tagLock = goutil.findChild(root, "tagLock")
	local tagPass = goutil.findChild(root, "tagPass")
	local tagSelect = goutil.findChild(root, "tagSelect")
	local prizeScrView = goutil.findChild(root, "prizeCol/scrView")
	local prizeScrCell = goutil.findChild(root, "prizeCol/scrCell")

	GameUtil.setLocalPos(root, self._rootPosVec.x, (index % 2 == 1 or nil) and (self._rootPosVec.y + 108 or self._rootPosVec.y), self._rootPosVec.z)
	GameUtil.SetActive(mainGo, true)

	if self._curStageId == stageId then
		if self._lastStageId ~= self._curStageId then
			local list = self._stageScrollerList:getData()

			if list then
				for i, v in ipairs(list) do
					if v.stageId == self._lastStageId then
						self._stageScrollerList:updateCellInViewByIndex(i - 1)

						break
					end
				end
			end
		end

		self._lastStageId = self._curStageId
		canvas.overrideSorting = true
		canvas.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 1
	else
		canvas.overrideSorting = false
	end

	txtName.text = string.format("%s-%s", self._zoneData.name, stageId)

	GameUtil.SetActive(tagLock, state == 1)
	GameUtil.SetActive(tagPass, state == 2)
	GameUtil.SetActive(tagSelect, state == 3)

	local loader = self._stageLoaders[mainGo]

	self._stageLoaders[mainGo] = RoleObjectPool.instance:addRoleToParent(loader, data.skinId, role, 1, nil, false, 0, 0)

	local infoList = {}

	for i, v in ipairs((not string.nilorempty(data.prize) or nil) and string.split(data.prize, "#")) do
		table.insert(infoList, {
			isPass = isPass,
			prizeStr = v
		})
	end

	if not self._prizeScrollListDic[mainGo] then
		local scrollList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		self._prizeScrollListDic[mainGo] = scrollList

		scrollList:setCenterMode(true)
		scrollList:dragNotifyParent()
		scrollList:reloadData(infoList)
	end
end

function StKnExpStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local root = goutil.findChild(mainGo, "root")
	local role = goutil.findChild(root, "role")
	local loader = self._stageLoaders[mainGo]

	if loader then
		self._stageLoaders[mainGo] = RoleObjectPool.instance:removeRole(loader)
	end

	local scrollList = self._prizeScrollListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._prizeScrollListDic[mainGo] = nil
	end
end

function StKnExpStageView:_updatePrizeCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tagGain = goutil.findChild(mainGo, "tagGain")

	MaterialMgr.setCellByCfg(info.prizeStr, item)
	GameUtil.SetActive(tagGain, info.isPass)
end

function StKnExpStageView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function StKnExpStageView:_onUpdateInfoColUI()
	local stageData = StKnExpConfig.instance:getStageData(self._activityId, self._zoneId, self._curStageId)

	if stageData == nil then
		self._curStageId = 0

		self:_onClearInfoCol()
		GameUtil.SetActive(self._infoCol, false)

		return
	else
		GameUtil.SetActive(self._infoCol, true)
	end

	local stageId = self._curStageId
	local creepsMasterId = stageData.creepsMasterId
	local creepsCfg = StKnExpConfig.instance:getCreepsCfg(creepsMasterId) or {}

	self._txtStage.text = string.format("%s-%s", self._zoneData.name, stageId)
	self._txtBuffDesc.text = stageData.buffDesc

	for posId = 1, self._fmtView.transform.childCount do
		local go = self._fmtView.transform:GetChild(posId - 1)
		local mask = goutil.findChild(go, "mask")
		local icon = goutil.findChild(go, "mask/icon")
		local creepsData

		for _, cData in ipairs(creepsCfg) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		GameUtil.SetActive(mask, creepsData ~= nil)

		if creepsData then
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(creepsData, creepsCfg)

			petMo.creepName = creepsData.creepName

			MaterialMgr.setIcon(icon, MatType.Pet, petMo.curFaceId)
			GameUtil.addClickHandler(go, function()
				CommonTipsMgr.instance:showPetTips(petMo)
			end)
		else
			MaterialMgr.clearIcon(icon)
		end
	end
end

function StKnExpStageView:_onClearInfoCol()
	for posId = 1, self._fmtView.transform.childCount do
		local go = self._fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "mask/icon")

		MaterialMgr.clearIcon(icon)
		GameUtil.rmClickHandler(go)
	end
end

function StKnExpStageView:_getInfoColVisuable()
	return GameUtil.GetActive(self._infoCol)
end

function StKnExpStageView:_onClickBtnEnter()
	if self._curStageId > 0 then
		StKnExpController.instance:enterBattleInStage(self._activityId, self._zoneId, self._curStageId)
	end
end

function StKnExpStageView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.StKnExpRankTabFatherView, self._activityId, StKnExpEnum.ClgType_Stage, self._zoneId)
end

function StKnExpStageView:_onClickBtnMining()
	UIStateManager.instance:push(ViewName.StKnExpMiningView, self._activityId)
end

function StKnExpStageView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.StKnExpBuffPreView, self._activityId)
end

return StKnExpStageView
