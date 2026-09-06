-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickAPetView.lua

module("logic.extensions.pickapet.view.PickAPetView", package.seeall)

local PickAPetView = class("PickAPetView", ViewComponent)

function PickAPetView:ctor()
	PickAPetView.super.ctor(self)
	NotifyDispatcher.extend(self)

	self._item_pets = nil
	self._max_row = 6
	self._max_col = 8
end

function PickAPetView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addListener(GlobalNotify.PickStartGame, self._onNextLevel, self)
	GlobalDispatcher:addListener(GlobalNotify.PickInfo, self._onRefreshPickInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.PickRight, self._onRightEffect, self)
	GlobalDispatcher:addListener(GlobalNotify.PickWrong, self._onWrongEffect, self)
end

function PickAPetView:unbindEvents()
	self._closeButton:RemoveClickListener()
	GlobalDispatcher:removeListener("OnPetSelect")
	GlobalDispatcher:removeListener(GlobalNotify.PickStartGame, self._onNextLevel, self)
	GlobalDispatcher:removeListener(GlobalNotify.PickInfo, self._onRefreshPickInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.PickRight, self._onRightEffect, self)
	GlobalDispatcher:removeListener(GlobalNotify.PickWrong, self._onWrongEffect, self)
end

function PickAPetView:buildUI()
	self._closeButton = self:getBtn("Game_Info/Btn_Close")
	self.container = self:getGo("Container")
	self._Txt_Gate = self:getGo("Game_Info/Txt_Gate"):GetComponent("Text")
	self._Txt_PetNum = self:getGo("Game_Info/Txt_PetNum"):GetComponent("Text")
	self._Game_Info = self:getGo("Game_Info")
	self._Txt_Collect = self:getGo("Game_Info/Txt_Collect"):GetComponent("Text")
	self._target_item = self:getGo("Game_Info/item_pet")
	self._item = self:getGo("item_pet")
	self._moveBy = self:getGo("Effect_Wrong"):GetComponent(UnityTweensType.TweenPositionBy)
	self._fadeOut = self:getGo("Effect_Wrong"):GetComponent(UnityTweensType.UITweenFadeOut)
	self._effectWrong = self:getGo("Effect_Wrong")

	self:_initCells()

	self._txtStart = self:getTxt("Pnl_start/Text")
	self._txtTarget = self:getTxt("Game_Info/Txt_Target")
end

function PickAPetView:_initCells()
	local cell = self:getGo("Pnl_start/container/item_pet")
	local parent = self:getGo("Pnl_start/container").transform

	self._cells = {}

	for i = 1, 15 do
		local cloneCell = goutil.cloneAndSetParent(cell, parent)

		table.insert(self._cells, cloneCell)
	end

	goutil.setActive(cell, false)
end

function PickAPetView:onEnter()
	PickAPetModel.instance:setDataCls(self:getFirstParam())

	self._pickAPetInfo = self:getFirstParam()

	self:_fillCells()
	self._Game_Info.gameObject:SetActive(false)

	self._txtStart.text = string.format("请在<color=#f26432>规定时间</color>内，快速找出<color=#f26432>目标数量</color>的<color=#f26432>%s</color>", self._pickAPetInfo:getViewDesc())
	self._txtTarget.text = self._pickAPetInfo:getViewDesc()
end

function PickAPetView:_fillCells()
	for i = 1, #self._cells do
		local cloneCell = self._cells[i]
		local img = goutil.findChildComponent(cloneCell, "ImgC_HeadIcon", "Image")
		local iconName1, iconName2 = self._pickAPetInfo:getIconName()
		local icon = i == 7 and iconName1 or iconName2

		uGuiUtil.setSpriteToImage(img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(icon))
	end
end

function PickAPetView:_clearCells()
	for i = 1, #self._cells do
		local cloneCell = self._cells[i]
		local img = goutil.findChild(cloneCell, "ImgC_HeadIcon")
		local bigBg = img:GetComponent(typeof(Framework.ImageBigBG))

		bigBg:ClearImage()
	end
end

function PickAPetView:_initGateInfo(key)
	self._item_pets = self._item_pets or {}

	PickAPetModel.instance:setLevelId(key)
	PickAPetModel.instance:initLevelInfo(key)

	local cfg = PickAPetModel.instance:getLevelCfg()

	for i = 1, cfg.rowAndCol[1] do
		for j = 1, cfg.rowAndCol[2] do
			local item_pet = self._item_pets[j + (i - 1) * cfg.rowAndCol[2]]

			if not item_pet then
				item_pet = goutil.clone(self._item)

				item_pet.gameObject:SetActive(true)
				goutil.addChildToParent(item_pet, self.container)

				local petsItem = GameUtil.AddLuaOnce(item_pet, PickItemView)

				petsItem:setCallBack(GameUtil.handler(self.close, self))

				self._item_pets[j + (i - 1) * cfg.rowAndCol[2]] = item_pet

				petsItem:addClickCallBack(GameUtil.handler(self._OnClickPet, self))
				GlobalDispatcher:addListener("OnPetSelect", function(newData)
					petsItem:OnSelectPetChanged(newData)
				end)
			end

			local petsItem = GameUtil.AddLuaOnce(item_pet, PickItemView)

			petsItem:setCallBack(GameUtil.handler(self.close, self))

			self._itemScale = 1

			local row_scale = self._max_row / cfg.rowAndCol[1]
			local col_scale = self._max_col / cfg.rowAndCol[2]

			if row_scale < 1 or col_scale < 1 then
				self._itemScale = row_scale < col_scale and row_scale or col_scale
			end

			item_pet.transform.localPosition = Vector3.New(-cfg.rowAndCol[2] / 2 * 100 * self._itemScale + (j - 1) * 100 * self._itemScale + 50 * self._itemScale, cfg.rowAndCol[1] / 2 * 100 * self._itemScale - 50 * self._itemScale - (i - 1) * 100 * self._itemScale - 50 * self._itemScale, 0)
			item_pet.transform.localScale = Vector3.New(self._itemScale, self._itemScale, self._itemScale)

			local iconId = PickAPetModel.instance:getIconArr()[j + (i - 1) * cfg.rowAndCol[2]]
			local petCo = CharacterConfig.instance:getPetCo(cfg.icons[iconId])

			petsItem:Init(petCo)
			petsItem:itemTag(j + (i - 1) * cfg.rowAndCol[2])
		end
	end

	MaterialMgr.setCell(MatType.Pet, cfg.icon, self._target_item)
end

function PickAPetView:onExit()
	GameUtil.RemoveLua(self._target_item, PickItemView)

	if self._item_pets then
		for i, v in ipairs(self._item_pets) do
			GameUtil.RemoveLua(v, PickItemView)
			goutil.destroy(v)
		end
	end

	PickAPetModel.instance:onExit()

	self._item_pets = nil
end

function PickAPetView:onExitFinished()
	self:_removeEffect()
	self:_clearCells()
end

function PickAPetView:_onClickClose()
	GlobalDispatcher:dispatch(GlobalNotify.PickPause, true)
	PickAPetController.instance:endGame(false, GameUtil.handler(self.close, self))
end

function PickAPetView:_OnClickPet(data)
	GlobalDispatcher:dispatch("OnPetSelect", data)
end

function PickAPetView:_removeEffect()
	if self._right_effs then
		for i, v in ipairs(self._right_effs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._right_effs = nil

	if self._wrong_effs then
		for i, v in ipairs(self._wrong_effs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._wrong_effs = nil
end

function PickAPetView:_onNextLevel()
	self:_removeEffect()
	self._Game_Info.gameObject:SetActive(true)

	local levelId = PickAPetModel.instance:getLevelId()

	self._Txt_Gate.text = string.format("第<color=#384a85>%d/%d</color>关", PickAPetModel.instance:getLevel() + 1, PickAPetModel.instance:getlevelNum())

	self:_initGateInfo(levelId + 1)
	self:_onRefreshPickInfo()
end

function PickAPetView:_onRefreshPickInfo()
	self._Txt_PetNum.text = string.format("本关目标真身数：<color=#aa5331>%d/%d</color>", PickAPetModel.instance:getCurPickPetNum(), PickAPetModel.instance:getTotalPickPetNum())
	self._Txt_Collect.text = tostring(PickAPetModel.instance:getCollect())
end

function PickAPetView:_onRightEffect(widget)
	local _right_eff = UIEffectManager.instance:playEffect(self, "fx_ui_feiniaomianban/fx_xuandui.prefab", widget, 0, 0, false, nil, nil, self._finishHandler, self)

	self._right_effs = self._right_effs or {}

	table.insert(self._right_effs, _right_eff)
end

function PickAPetView:_onWrongEffect(widget)
	local _wrong_eff = UIEffectManager.instance:playEffect(self, "fx_ui_feiniaomianban/fx_xuancuo.prefab", widget, 0, 0, false, nil, nil, self._finishHandler, self)

	self._wrong_effs = self._wrong_effs or {}

	table.insert(self._wrong_effs, _wrong_eff)
	self._effectWrong.gameObject:SetActive(true)

	self._effectWrong.gameObject.transform.localPosition = Vector3.New(0, 0, 0)

	self._moveBy:Begin()
	self._fadeOut:Begin()
end

function PickAPetView:_finishHandler(eff)
	UIEffectManager.instance:updateEffectScale(eff, 0.25, 0.25, 0.25)
	UIEffectManager.instance:updateEffectPosition(eff)
end

return PickAPetView
