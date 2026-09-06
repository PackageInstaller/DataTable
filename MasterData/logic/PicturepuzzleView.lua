-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/view/PicturepuzzleView.lua

module("logic.extensions.picturepuzzle.view.PicturepuzzleView", package.seeall)

local PicturepuzzleView = class("PicturepuzzleView", ViewComponent)

function PicturepuzzleView:buildUI()
	PicturepuzzleView.super.buildUI(self)

	self._closeBtn = self:getBtn("bg/closeBtn")
	self._basePicture = self:getGo("basePicture")
	self._picture = self:getGo("picture")
	self._chip = self:getGo("chip")
	self._chipCell = self:getGo("chipCell")
	self._scrollrect = goutil.findChildComponent(self.mainGO, "chipView", typeof(UnityEngine.UI.ScrollRect))
	self._chipView = ScrollerList.create(self:getGo("chipView"), self._chipCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PicturepuzzleView:bindEvents()
	PicturepuzzleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickclose, self)
end

function PicturepuzzleView:unbindEvents()
	PicturepuzzleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PicturepuzzleView:onEnter()
	PicturepuzzleView.super.onEnter(self)

	local openParam = self:getOpenParam()
	local data = openParam[1]

	self._planId = data.planId
	self._openDay = data.openDay
	self._shareId = data.shareId
	self._clientKey = openParam[2]
	self._encryptedKey = openParam[3]
	self._actId = openParam[4]
	self._chipList = JigsawcollectConfig.instance:getPiecePlanCfgs(tonumber(self._planId))
	self._chips = {}

	uGuiUtil.setSpriteToImage(self._basePicture, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("picturepuzzle/" .. data.baseIcon))

	self._shareIcon = data.shareIcon

	local oldData = PicturepuzzleController.instance:getSuspendData(self._planId)

	for i, data in ipairs(self._chipList) do
		self._chips[i] = goutil.cloneAndSetParent(self._chip, self._picture.transform, "chip_" .. i)

		goutil.setActive(self._chips[i], true)

		local go = goutil.findChild(self._chips[i], "Image")

		uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("picturepuzzle", data.icon))
		uGuiUtil.setGoGrayState(self._chips[i], not oldData or oldData[i])
	end

	self._cellBeginDragHandler = {}
	self._cellEndDragHandler = {}
	self._cellDragHandler = {}
	self._cellBeginDragHandlerCode = {}
	self._cellEndDragHandlerCode = {}
	self._cellDragHandlerCode = {}

	self._chipView:reloadData(PicturepuzzleController.instance:randomChip(self._chipList, self._chips, self._planId))

	self._viewEff = UIEffectManager.instance:playEffect(self, "fx_ui_xinxiyamianban/fx_ui_pintu_loop_xinxiyayure.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
	end)
	self._effList = {}
end

function PicturepuzzleView:onExit()
	PicturepuzzleView.super.onExit(self)
	FixedUpdateBeat:Remove(self._trueAnimation, self)
	FixedUpdateBeat:Remove(self._falseAnimation, self)
	uGuiUtil.clearImage(self._basePicture)
	PicturepuzzleController.instance:saveSuspendData(self._planId, self._chipView:getData())
	self._chipView:dispose()
	UIEffectManager.instance:stopEffect(self._viewEff)
end

function PicturepuzzleView:onExitFinished()
	PicturepuzzleView.super.onExitFinished(self)

	for i, v in ipairs(self._chips) do
		goutil.destroy(v)
	end

	for i, v in ipairs(self._effList) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function PicturepuzzleView:_updateCell(view, cell, data)
	self._cellBeginDragHandler[cell] = self._cellBeginDragHandler[cell] or BeginDragHandler.Get(cell.gameObject)
	self._cellEndDragHandler[cell] = self._cellEndDragHandler[cell] or EndDragHandler.Get(cell.gameObject)
	self._cellDragHandler[cell] = self._cellDragHandler[cell] or DragHandler.Get(cell.gameObject)

	if self._cellBeginDragHandlerCode[cell] then
		self._cellBeginDragHandler[cell]:RemoveLuaHandler(self._cellBeginDragHandlerCode[cell])
	end

	if self._cellEndDragHandlerCode[cell] then
		self._cellEndDragHandler[cell]:RemoveLuaHandler(self._cellEndDragHandlerCode[cell])
	end

	if self._cellDragHandlerCode[cell] then
		self._cellDragHandler[cell]:RemoveLuaHandler(self._cellDragHandlerCode[cell])
	end

	self._cellBeginDragHandlerCode[cell] = self._cellBeginDragHandler[cell]:AddLuaHandler(function(_go, eventData)
		self:_OnBeginDragSeat(_go, eventData, data.icon)
	end)
	self._cellEndDragHandlerCode[cell] = self._cellEndDragHandler[cell]:AddLuaHandler(function(_go, eventData)
		self:_OnEndDragSeat(_go, eventData, data.tarId, data.target)
	end)
	self._cellDragHandlerCode[cell] = self._cellDragHandler[cell]:AddLuaHandler(function(_go, eventData)
		self:_OnDragSeat(_go, eventData)
	end)

	uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("picturepuzzle", data.icon))
end

function PicturepuzzleView:_clearCell(cell)
	uGuiUtil.clearImage(cell.gameObject)

	if self._cellBeginDragHandlerCode[cell] then
		self._cellBeginDragHandler[cell]:RemoveLuaHandler(self._cellBeginDragHandlerCode[cell])

		self._cellBeginDragHandler[cell] = nil
	end

	if self._cellEndDragHandlerCode[cell] then
		self._cellEndDragHandler[cell]:RemoveLuaHandler(self._cellEndDragHandlerCode[cell])

		self._cellEndDragHandler[cell] = nil
	end

	if self._cellDragHandlerCode[cell] then
		self._cellDragHandler[cell]:RemoveLuaHandler(self._cellDragHandlerCode[cell])

		self._cellDragHandler[cell] = nil
	end
end

function PicturepuzzleView:_OnBeginDragSeat(_go, eventData, icon)
	local drag = math.abs(eventData.delta.y) > math.abs(eventData.delta.x)

	if drag and not self._dragFlag then
		self._dragFlag = true
		self._dragGo = goutil.cloneAndSetParent(self._chip, self.mainGO.transform)

		goutil.setActive(self._dragGo, true)

		local iconGo = goutil.findChild(self._dragGo, "Image")

		uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("picturepuzzle", icon))

		self._dragGo.transform.position = _go.transform.position

		local x, y = Framework.TransformUtil.GetAnchoredPos(self._dragGo:GetComponent(goutil.Type_RectTransform), 0, 0)

		self._animParam = {
			animTime = 0,
			beginVec = Vector2.New(x, y)
		}
	else
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function PicturepuzzleView:_OnEndDragSeat(_go, eventData, id, target)
	if self._dragFlag then
		local x, y = Framework.TransformUtil.GetAnchoredPos(self._dragGo:GetComponent(goutil.Type_RectTransform), 0, 0)
		local tarX, tarY = Framework.TransformUtil.GetAnchoredPos(target:GetComponent(goutil.Type_RectTransform), 0, 0)
		local x1, y1 = Framework.TransformUtil.GetAnchoredPos(self._picture:GetComponent(goutil.Type_RectTransform), 0, 0)
		local width, height = goutil.getWidth(self._picture:GetComponent(goutil.Type_RectTransform)), goutil.getHeight(self._picture:GetComponent(goutil.Type_RectTransform))

		tarX = tarX - width / 2 + x1
		tarY = tarY + height / 2 + y1

		if (x - tarX)^2 + (y - tarY)^2 < 2500 then
			self._animParam.tarId = id
			self._animParam.tarGo = self._chips[id]
			self._animParam.endVec = Vector2.New(tarX, tarY)
			self._animParam.beginVec = Vector2.New(x, y)

			FixedUpdateBeat:Add(self._trueAnimation, self)
		else
			self._animParam.endVec = Vector2.New(x, y)

			FixedUpdateBeat:Add(self._falseAnimation, self)
		end
	else
		self._scrollrect:OnEndDrag(eventData)
	end
end

function PicturepuzzleView:_OnDragSeat(_go, eventData)
	if self._dragFlag then
		self._dragGo.transform.position = uGuiUtil.GetTouchWorldPosition()
	else
		self._scrollrect:OnDrag(eventData)
	end
end

function PicturepuzzleView:_trueAnimation()
	if self._animParam.animTime <= 1 then
		local vec = Vector2.Lerp(self._animParam.beginVec, self._animParam.endVec, self._animParam.animTime)

		Framework.TransformUtil.SetAnchoredPos(self._dragGo:GetComponent(goutil.Type_RectTransform), vec.x, vec.y)

		self._animParam.animTime = self._animParam.animTime + 0.05
	else
		local newData = {}

		for i, v in ipairs(self._chipView:getData()) do
			if v.tarId ~= self._animParam.tarId then
				table.insert(newData, v)
			end
		end

		self._chipView:reloadData(newData)
		uGuiUtil.setGoGrayState(self._animParam.tarGo, false)

		local effect = UIEffectManager.instance:playEffect(self, "fx_ui_xinxiyamianban/fx_ui_xinxiya_jiemianxuanzhong.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
			eff:setParent(self._animParam.tarGo.transform)
			eff:setScale(1)
			eff:setLocalPos()
		end)

		table.insert(self._effList, effect)
		goutil.destroy(self._dragGo)

		self._dragGo = nil
		self._dragFlag = false

		FixedUpdateBeat:Remove(self._trueAnimation, self)

		if #newData <= 0 then
			local effect = UIEffectManager.instance:playEffect(self, "fx_ui_xinxiyamianban/fx_ui_pintu_wancheng_xinxiya.prefab", nil, nil, nil, false, nil, function(_, eff)
				UIStateManager.instance:push(ViewName.PicturepuzzleshareView, self._shareIcon, self._shareId)
				PicturepuzzleController.instance:sendPM_PuzzleJigsawEndGameReq(1, GameUtil.getClientEncryptedKey(self._clientKey, self._encryptedKey, {
					self._actId,
					self._planId,
					1
				}))
				self:close()
			end, function(_, eff)
				eff:setParent(self.mainGO.transform)
				eff:setScale(1)
				eff:setLocalPos()
			end)

			table.insert(self._effList, effect)
		end
	end
end

function PicturepuzzleView:_falseAnimation()
	if self._animParam.animTime <= 1 then
		local vec = Vector2.Lerp(self._animParam.endVec, self._animParam.beginVec, self._animParam.animTime)

		Framework.TransformUtil.SetAnchoredPos(self._dragGo:GetComponent(goutil.Type_RectTransform), vec.x, vec.y)

		self._animParam.animTime = self._animParam.animTime + 0.05
	else
		goutil.destroy(self._dragGo)

		self._dragGo = nil
		self._dragFlag = false

		FixedUpdateBeat:Remove(self._falseAnimation, self)
	end
end

function PicturepuzzleView:_onClickclose()
	TipsFacade.instance:openPopupWindow(lang("tip"), lang("重新登录游戏后，拼图进度将【无法保存】，是否确认关闭拼图界面？"), function()
		self:close()
	end)
end

return PicturepuzzleView
