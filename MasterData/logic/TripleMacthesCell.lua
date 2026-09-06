-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesCell.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesCell", package.seeall)

local TripleMacthesCell = class("TripleMacthesCell")

TripleMacthesCell.BreakBoxRes = "icon_bs14"

function TripleMacthesCell:ctor(componetContainer, view)
	self._view = view
	self._container = componetContainer
	self._cellData = nil
	self.moveDistance = 50
	self._x_space = 80
	self._y_space = 80
	self._downPosition = nil
	self._fadeOutTag = false
	self._moveList = Array.New()
end

function TripleMacthesCell:initCell(cellDat)
	self:onBuildUI()
	self:onBuildEvent()
	self:resetCell(cellDat)
	self._moveList:Clear()
end

function TripleMacthesCell:resetCell(cellDat)
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	self._cellData = cellDat
	self._container.name = tostring(cellDat._y * 10 + cellDat._x)
	self._imgMain:GetComponent(goutil.Type_UIImage).color = Color.white

	self._container.gameObject:SetActive(true)

	local canvasGroup = self._container.gameObject:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = 1

	GameUtil.SetActive(self._IceGo, false)

	if self._cellData then
		local iceLevel = 0

		if self._cellData._addType and #self._cellData._addType > 0 then
			for i, v in pairs(self._cellData._addType) do
				if v >= SxGameCellAddType.Ice_1 and v <= SxGameCellAddType.Ice_7 and iceLevel < v then
					iceLevel = v
				end
			end
		end

		if iceLevel > 0 and self._cellData._type ~= SxGameCellType.EmptyShow and self._cellData._type ~= SxGameCellType.Empty then
			GameUtil.SetActive(self._IceGo, true)
			self._IceImageChange:SetState(iceLevel - 1)
		end

		local blockCfg = TripleMachesGameConfig.instance:getBlockInfo(self._cellData._type)
		local breakBox = false

		if iceLevel > 0 and (self._cellData._type == SxGameCellType.EmptyShow or self._cellData._type == SxGameCellType.Empty) then
			if iceLevel < TripleMacthesGameModel.instance:getBoxDefualtCount() then
				breakBox = true
			else
				blockCfg = TripleMachesGameConfig.instance:getBlockInfo(SxGameCellType.Box)
			end
		end

		local iconReplace = TripleMacthesGameModel.instance:getIconReplaceCfg()

		uGuiUtil.clearImage(self._imgMainGo)

		if breakBox == true then
			uGuiUtil.setSpriteToImage(self._imgMainGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", TripleMacthesCell.BreakBoxRes))
		elseif blockCfg and iconReplace[blockCfg.blockId] then
			uGuiUtil.setSpriteToImage(self._imgMainGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", iconReplace[blockCfg.blockId].icon))
		elseif blockCfg and not string.nilorempty(blockCfg.icon) then
			uGuiUtil.setSpriteToImage(self._imgMainGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", blockCfg.icon))
		end

		if self._cellData._type == SxGameCellType.RainbowBall then
			local subType = 0

			for i, v in ipairs(self._cellData._addType) do
				if TripleMacthesGameModel.instance:isCanRemoveType(v) then
					subType = v
				end
			end

			local subBlockCfg = TripleMachesGameConfig.instance:getBlockInfo(subType)

			if subBlockCfg then
				uGuiUtil.setSpriteToImage(self._imgSubTypeCon, nil, GameUrl.getBigbgFolderUrl("triplemacthes", subBlockCfg.icon))
			end

			GameUtil.SetActive(self._imgSubTypeGo, subType ~= 0)
		else
			GameUtil.SetActive(self._imgSubTypeGo, false)
		end

		if self._cellData._type == SxGameCellType.Flash then
			GameUtil.setLocalRotation(self._imgMainGo, 0, 0, 22)
		elseif self._cellData._type == SxGameCellType.FlashShu then
			GameUtil.setLocalRotation(self._imgMainGo, 0, 0, -22)
		else
			GameUtil.setLocalRotation(self._imgMainGo, 0, 0, 0)
		end

		if self._cellData._type == SxGameCellType.RainbowBall then
			GameUtil.SetActive(self._imgMainGo, false)

			local effName = "20240403/sanxiaowanfa/fx_ui_caihongqiu.prefab"

			self._effect = UIEffectManager.instance:playEffect(self._view, effName, nil, 0, 0, true)

			self._effect:setParent(self._effectGo.transform)
			self._effect:setScale(1)
			self._effect:setLocalPos(0, 0, 0)
		else
			GameUtil.SetActive(self._imgMainGo, true)

			if self._effect then
				UIEffectManager.instance:stopEffect(self._effect)

				self._effect = nil
			end
		end
	end
end

function TripleMacthesCell:refeshCellView(x, y)
	if self._cellData then
		if not self._cellData._type then
			local str = ""

			if self._cellData._addType and #self._cellData._addType > 0 then
				for i, v in ipairs(self._cellData._addType) do
					str = str .. "-" .. v
				end
			end

			str = str .. "\n" .. self._cellData._x .. "," .. self._cellData._y
			str = x and y and str .. "\n" .. x .. "," .. y or str .. "\n" .. self._cellData._x .. "," .. self._cellData._y
			self._txt.text = str
		end
	end
end

function TripleMacthesCell:getObj()
	return self._container
end

function TripleMacthesCell:getType()
	return self._cellData._type
end

function TripleMacthesCell:getAddType()
	return self._cellData._addType
end

function TripleMacthesCell:onBuildUI()
	self._CellBtn = Framework.ButtonAdapter.Get(self._container.gameObject)
	self._IceGo = goutil.findChild(self._container.gameObject, "imgIce")
	self._IceImageChange = goutil.findChildComponent(self._container.gameObject, "imgIce", "UIImageSpriteChange")
	self._moveBy = self._container:GetComponent(UnityTweensType.TweenPositionBy)
	self._drag = Framework.UIDragTrigger.Get(self._container.gameObject)
	self._imgMainGo = goutil.findChild(self._container.gameObject, "imgMain")
	self._imgMain = self._imgMainGo:GetComponent(goutil.Type_UIImage)
	self._imgSubTypeGo = goutil.findChild(self._container.gameObject, "exclSptGo")
	self._imgSubTypeCon = goutil.findChild(self._imgSubTypeGo, "imgSubType")
	self._fadeOut = self._container.gameObject:GetComponent(UnityTweensType.UITweenFadeOut)
	self._txt = goutil.findChildTextComponent(self._container.gameObject, "txt")
	self._effectGo = goutil.findChild(self._container.gameObject, "effect")
end

function TripleMacthesCell:onBuildAction(moveByFunc)
	self._moveList:Clear()

	self._moveByFunc = moveByFunc

	local dir = Vector3.New(0, -self._container.transform.localPosition.y + self._y_space * (self._cellData._y - 1), 0)

	if self._moveList:IsEmpty() then
		self._moveBy.positionBy = dir
	end

	self._moveList:PushBack(dir)
	self._moveBy:Begin()
end

function TripleMacthesCell:onBuildEvent()
	self._CellBtn:AddClickListener(self._onClickCell, self)
	self._moveBy:AddListener(self._moveByFinishCallBack, self)
	self._fadeOut:AddListener(self._fadeOutFinishCallBack, self)

	self._pointerDown = PointerDownHandler.Get(self._container.gameObject):AddLuaHandler(function(obj, eventData)
		self:onPointDown(obj, eventData)
	end)

	self._drag:AddDragListener(self._onDrag, self)
end

function TripleMacthesCell:_onClickCell()
	return
end

function TripleMacthesCell:onChangePos(x, y, moveByFunc)
	self._moveByFunc = moveByFunc
	self._container.name = tostring(y * 10 + x)

	local dir = Vector3.New(self._x_space * (x - self._cellData._x), self._y_space * (y - self._cellData._y), 0)

	if self._moveList:IsEmpty() then
		self._moveBy.positionBy = dir
	end

	self._moveList:PushBack(dir)
	self._moveBy:Begin()
end

function TripleMacthesCell:onRemove(removeFunc)
	self._removeFunc = removeFunc

	self._fadeOut:Stop()

	local canvasGroup = self._container.gameObject:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = 1

	self._fadeOut:Begin()

	if self._fadeOutTag == false then
		self._fadeOutTag = true

		TripleMacthesGameModel.instance:addRemoveCount()
	end
end

function TripleMacthesCell:_moveByFinishCallBack()
	self._moveList:PopFront()

	if not self._moveList:IsEmpty() then
		self._moveBy.positionBy = self._moveList:Get(0)

		self._moveBy:Begin()
	end

	if self._moveByFunc and self._moveList:IsEmpty() then
		self._moveByFunc()
	end
end

function TripleMacthesCell:onPointDown(obj, eventData)
	TripleMachesGameController.instance:addAction(self._cellData)

	self._downPosition = TableUtil.deepcopy(eventData.position)

	if TripleMachesGameController.instance:isCanDoAction() then
		-- block empty
	end
end

function TripleMacthesCell:_onDrag(eventData)
	if not TripleMachesGameController.instance:isCanDoAction() or not self._downPosition then
		return
	end

	local x = self._cellData._x
	local y = self._cellData._y

	if eventData.position.x - self._downPosition.x > self.moveDistance then
		self:onDoSwapAction(x + 1, y)

		return
	end

	if eventData.position.x - self._downPosition.x < -self.moveDistance then
		self:onDoSwapAction(x - 1, y)

		return
	end

	if eventData.position.y - self._downPosition.y > self.moveDistance then
		self:onDoSwapAction(x, y + 1)

		return
	end

	if eventData.position.y - self._downPosition.y < -self.moveDistance then
		self:onDoSwapAction(x, y - 1)

		return
	end
end

function TripleMacthesCell:onDoSwapAction(newX, newY)
	self._downPosition = nil

	local x = self._cellData._x
	local y = self._cellData._y

	TripleMacthesGameModel.instance:removeAction()
	TripleMachesGameController.instance:addActionByGuest(x, y)
	TripleMachesGameController.instance:addActionByGuest(newX, newY)
end

function TripleMacthesCell:addSelEffect()
	if not self._selEffect then
		self._selEffect = UIEffectManager.instance:playHUDEffect("fx_ui_sanxiao/fx_ui_xuanzhong.prefab", self._container.gameObject, true, nil, nil, function(finishHandlerTarget, eff)
			return
		end)

		self._selEffect:setSortingOrder(251)
	end
end

function TripleMacthesCell:removeSelEffect()
	if self._selEffect then
		UIEffectManager.instance:stopEffect(self._selEffect)

		self._selEffect = nil
	end
end

function TripleMacthesCell:_fadeOutFinishCallBack()
	if self._removeFunc then
		self:removeSelEffect()
		self:_removeFunc()
	end

	self._fadeOutTag = false

	self._container.gameObject:SetActive(false)
end

function TripleMacthesCell:returnToPool()
	self:removeSelEffect()
	self._container.gameObject:SetActive(false)
end

function TripleMacthesCell:onDestroy()
	self:removeSelEffect()
	self._CellBtn:RemoveClickListener()

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	PointerDownHandler.Get(self._container.gameObject):RemoveLuaHandler(self._pointerDown)
	goutil.destroy(self._container.gameObject)
end

return TripleMacthesCell
