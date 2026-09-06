-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/view/CloudCutFanRepairView.lua

module("logic.extensions.cloudcutfan.view.CloudCutFanRepairView", package.seeall)

local CloudCutFanRepairView = class("CloudCutFanRepairView", ViewComponent)
local tipCellCount = 3

function CloudCutFanRepairView:ctor()
	CloudCutFanRepairView.super.ctor(self)
end

function CloudCutFanRepairView:unbindEvents()
	CloudCutFanRepairView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	self._dropHandlerMap = self._dropHandlerMap or {}

	for go, handler in pairs(self._dropHandlerMap) do
		DropHandler.Get(go):RemoveLuaHandler(handler)
	end

	self._dropHandlerMap = {}
end

function CloudCutFanRepairView:bindEvents()
	CloudCutFanRepairView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	self._dropHandlerMap = self._dropHandlerMap or {}

	for i, cell in ipairs(self._repairCellList) do
		self._dropHandlerMap[cell.trigger] = DropHandler.Get(cell.trigger):AddLuaHandler(function(_go, eventData)
			self:_OnDropSeat(_go, eventData, i)
		end)
	end
end

function CloudCutFanRepairView:buildUI()
	CloudCutFanRepairView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._topFan = self:getGo("showFan/top")
	self._faceFan = self:getGo("showFan/cover/face")
	self._tailFan = self:getGo("showFan/tail")
	self._coverFan = self:getGo("showFan/cover")
	self._repairCellList = {}

	for i = 1, tipCellCount do
		local cell = {}

		cell.go = self:getGo("repairPos/pos" .. i)
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "title/txt")
		cell.bg = goutil.findChild(cell.go, "bg")
		cell.trigger = goutil.findChild(cell.go, "trigger")
		cell.mask = goutil.findChild(cell.go, "bg/mask")
		cell.icon = goutil.findChild(cell.go, "bg/mask/icon")

		table.insert(self._repairCellList, cell)
	end

	local goTab = self:getGo("right/tableview")
	local goCell = self:getGo("right/tableview/tablecell")

	self._tableview = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._icon = self:getGo("mask/icon")
	self._mask = self:getGo("mask")
end

function CloudCutFanRepairView:onExit()
	CloudCutFanRepairView.super.onExit(self)
	uGuiUtil.clearImage(self._topFan)
	uGuiUtil.clearImage(self._tailFan)
	uGuiUtil.clearImage(self._coverFan)
	uGuiUtil.clearImage(self._faceFan)
	uGuiUtil.clearImage(self._icon)

	for i, cell in ipairs(self._repairCellList) do
		uGuiUtil.clearImage(cell.icon)
	end

	self._tableview:dispose()
	removetimer(self._freshList, self)
end

function CloudCutFanRepairView:onEnter()
	CloudCutFanRepairView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_CloudCutFanUnLockFaceRes, self._handleUnlockFaceRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = CloudCutFanController.instance:getDefaultActivityId() or 0
	end

	self._curFaceId = checknumber(params[2])

	if not self:_checkIsExistCfg() then
		self:close()

		return
	end

	self:_updateUIByCfg()
	goutil.setActive(self._mask, false)
end

function CloudCutFanRepairView:_checkIsExistCfg()
	self._curFaceCfg = CloudCutFanConfig.instance:getFanFaceCfgById(self._activityId, self._curFaceId)

	if not self._curFaceCfg then
		return false
	end

	return true
end

function CloudCutFanRepairView:_updateUIByCfg()
	self._actCfg = CloudCutFanConfig.instance:getActCfgByActId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_refreshPreviewFan()

	self._rightIdMap = {}
	self._curFixIdMap = {}
	self._notUsedIds = {}

	if not self._curFaceCfg.fixTips then
		local fixTips = {}

		for i, tipsId in ipairs(fixTips) do
			table.insert(self._notUsedIds, tipsId)

			self._curFixIdMap[i] = 0
			self._rightIdMap[i] = tipsId
		end

		GameUtil.permuteArray(self._notUsedIds)

		for i, cell in ipairs(self._repairCellList) do
			if not self._rightIdMap[i] then
				goutil.setActive(cell.go, false)
			else
				goutil.setActive(cell.go, true)
			end
		end

		for i, tipsId in pairs(self._rightIdMap) do
			self:_tryFixPos(i, 0)
		end

		self:_freshList()
	end
end

function CloudCutFanRepairView:_handleUnlockFaceRes()
	TipsFacade.instance:openTipWindowNoX(lang("提示"), lang("完成修复"), function()
		self:close()
	end)
end

function CloudCutFanRepairView:_freshList()
	self._notUsedIds = self._notUsedIds or {}

	self._tableview:reloadData(self._notUsedIds)
end

function CloudCutFanRepairView:_refreshPreviewFan()
	uGuiUtil.clearImage(self._topFan)
	uGuiUtil.clearImage(self._tailFan)
	uGuiUtil.clearImage(self._coverFan)
	uGuiUtil.clearImage(self._faceFan)

	local topMatId = checknumber(8)
	local topMatCfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, topMatId)

	if topMatCfg then
		local topPath = topMatCfg.picPath
		local coverPath = string.format("%s_02", topPath)
		local trueTopPath = CloudCutFanController.instance:getUseMatPicUrl(topPath)
		local trueCoverPath = CloudCutFanController.instance:getUseMatPicUrl(coverPath)

		if not GameUtil.isEmptyString(trueTopPath) then
			uGuiUtil.setSpriteToImage(self._topFan, uGuiUtil.SpriteType.BigBg, trueTopPath, function()
				local img = self._topFan:GetComponent(goutil.Type_UIImage)

				img:SetNativeSize()

				img.raycastTarget = false
			end)
		end

		if not GameUtil.isEmptyString(trueCoverPath) then
			uGuiUtil.setSpriteToImage(self._coverFan, uGuiUtil.SpriteType.BigBg, trueCoverPath, function()
				local img = self._coverFan:GetComponent(goutil.Type_UIImage)

				img:SetNativeSize()

				img.raycastTarget = false
			end)
		end
	end

	local tailMatId = checknumber(10)
	local tailCfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, tailMatId)

	if tailCfg then
		local trueTailPath = CloudCutFanController.instance:getUseMatPicUrl(tailCfg.picPath)

		if not GameUtil.isEmptyString(trueTailPath) then
			uGuiUtil.setSpriteToImage(self._tailFan, uGuiUtil.SpriteType.BigBg, trueTailPath, function()
				local img = self._tailFan:GetComponent(goutil.Type_UIImage)

				img:SetNativeSize()

				img.raycastTarget = false
			end)
		end
	end

	local trueFacePath = CloudCutFanController.instance:getUseMatPicUrl(self._curFaceCfg.bookPic)

	if not GameUtil.isEmptyString(trueFacePath) then
		uGuiUtil.setSpriteToImage(self._faceFan, uGuiUtil.SpriteType.BigBg, trueFacePath, function()
			local img = self._faceFan:GetComponent(goutil.Type_UIImage)

			img:SetNativeSize()

			img.raycastTarget = false
		end)
	end
end

function CloudCutFanRepairView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function CloudCutFanRepairView:_OnDropSeat(go, data, posId)
	if not self._isDraging then
		return
	end

	self:_tryFixPos(posId, checknumber(self._curDragId))
	removetimer(self._freshList, self)
	settimer(0.1, self._freshList, self, false)
end

function CloudCutFanRepairView:_tryFixPos(posId, tryFixId)
	local cell = self._repairCellList[posId]

	if not cell then
		return
	end

	local isFixed = self._curFixIdMap[posId] ~= 0

	if isFixed then
		return
	end

	local rightId = self._rightIdMap[posId]
	local isRight = rightId == tryFixId

	if isRight then
		local newIds = {}

		for i, id in ipairs(self._notUsedIds) do
			if id ~= tryFixId then
				table.insert(newIds, id)
			end
		end

		self._notUsedIds = newIds
		self._curFixIdMap[posId] = rightId
	end

	local tipCfg = CloudCutFanConfig.instance:getRepairTipsCfg(self._activityId, rightId) or {}

	if not tipCfg.fixTips then
		cell.txtTitle.text = ""
	end

	local picPath = CloudCutFanController.instance:getUseMatPicUrl(tipCfg.showPic)

	if not GameUtil.isEmptyString(picPath) then
		uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, picPath, function()
			local img = cell.icon:GetComponent(goutil.Type_UIImage)

			img:SetNativeSize()

			img.raycastTarget = false
		end)
	end

	goutil.setActive(cell.mask, isRight)

	if not tipCfg.pos then
		local pos = {
			0,
			0
		}

		GameUtil.setAnchoredPos(cell.go, checknumber(pos[1]), checknumber(pos[2]))

		if #self._notUsedIds <= 0 then
			CloudCutFanController.instance:unLockFace(self._activityId, self._curFaceId)
		end
	end
end

function CloudCutFanRepairView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local mask = goutil.findChild(go, "bg/mask")
	local icon = goutil.findChild(go, "bg/mask/icon")
	local tipCfg = CloudCutFanConfig.instance:getRepairTipsCfg(self._activityId, data) or {}
	local picPath = CloudCutFanController.instance:getUseMatPicUrl(tipCfg.showPic)

	if not GameUtil.isEmptyString(picPath) then
		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, picPath, function()
			local img = icon:GetComponent(goutil.Type_UIImage)

			img:SetNativeSize()

			img.raycastTarget = false
		end)
	end

	self._beginDragHandlerMap = self._beginDragHandlerMap or {}
	self._beginDragHandlerMap[mask] = BeginDragHandler.Get(mask):AddLuaHandler(function(_go, eventData)
		self:_onDragBeginHandler(_go, eventData, data)
	end)
	self._endDragHandlerMap = self._endDragHandlerMap or {}
	self._endDragHandlerMap[mask] = EndDragHandler.Get(mask):AddLuaHandler(function(_go, eventData)
		self:_onDragEndHandler(_go, eventData, data)
	end)
	self._dragHandlerMap = self._dragHandlerMap or {}
	self._dragHandlerMap[mask] = DragHandler.Get(mask):AddLuaHandler(function(_go, eventData)
		self:_onDragHandler(_go, eventData, data)
	end)

	GameUtil.setAnchoredPos(mask, -1, 3)
end

function CloudCutFanRepairView:_clearCell(cell)
	local go = cell.gameObject
	local mask = goutil.findChild(go, "bg/mask")
	local icon = goutil.findChild(go, "bg/mask/icon")

	uGuiUtil.clearImage(icon)

	self._beginDragHandlerMap = self._beginDragHandlerMap or {}
	self._endDragHandlerMap = self._endDragHandlerMap or {}
	self._dragHandlerMap = self._dragHandlerMap or {}

	local beginDragHander = self._beginDragHandlerMap[mask]

	if beginDragHander then
		BeginDragHandler.Get(mask):RemoveLuaHandler(beginDragHander)

		self._beginDragHandlerMap[mask] = nil
	end

	local endDragHander = self._endDragHandlerMap[mask]

	if beginDragHander then
		EndDragHandler.Get(mask):RemoveLuaHandler(endDragHander)

		self._endDragHandlerMap[mask] = nil
	end

	local dragHander = self._dragHandlerMap[mask]

	if dragHander then
		DragHandler.Get(mask):RemoveLuaHandler(dragHander)

		self._dragHandlerMap[mask] = nil
	end
end

function CloudCutFanRepairView:_onDragBeginHandler(go, eventData, data)
	self._isDraging = true
	self._curDragId = checknumber(data)

	local icon = goutil.findChild(go, "icon")

	goutil.setActive(icon, false)
	goutil.setActive(self._mask, true)
	self:_updateDragPos(eventData)

	local tipCfg = CloudCutFanConfig.instance:getRepairTipsCfg(self._activityId, self._curDragId) or {}
	local picPath = CloudCutFanController.instance:getUseMatPicUrl(tipCfg.showPic)

	if not GameUtil.isEmptyString(picPath) then
		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, picPath, function()
			local img = self._icon:GetComponent(goutil.Type_UIImage)

			img:SetNativeSize()

			img.raycastTarget = false
		end)
	end
end

function CloudCutFanRepairView:_onDragEndHandler(go, eventData, data)
	local icon = goutil.findChild(go, "icon")

	goutil.setActive(icon, true)
	goutil.setActive(self._mask, false)

	self._isDraging = false
	self._curDragId = 0

	uGuiUtil.clearImage(self._icon)
end

function CloudCutFanRepairView:_onDragHandler(go, eventData, data)
	self:_updateDragPos(eventData)
end

function CloudCutFanRepairView:_updateDragPos(eventData)
	local trans = self.mainGO.transform
	local vec = goutil.screenToLocalPos(eventData.position, trans)
	local pos = trans:TransformPoint(vec)
	local localPos = trans:InverseTransformPoint(pos) or Vector3.zero

	GameUtil.setAnchoredPos(self._mask, localPos.x, localPos.y)
end

return CloudCutFanRepairView
