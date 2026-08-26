-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheEventChoiceItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheEventChoiceItem", package.seeall)

local SodacheEventChoiceItem = class("SodacheEventChoiceItem", SodacheDialogueItem)

function SodacheEventChoiceItem:initView()
	self.goOptionItem = gohelper.findChild(self.go, "#go_suboptionitem")

	gohelper.setActive(self.goOptionItem, false)
end

function SodacheEventChoiceItem:onInitData(data)
	gohelper.CreateObjList(self, self._createItem, data, nil, self.goOptionItem)
end

function SodacheEventChoiceItem:calculateHeight()
	ZProj.UGUIHelper.RebuildLayout(self.go.transform)

	self.height = recthelper.getHeight(self.go.transform)
end

function SodacheEventChoiceItem:_createItem(obj, data, index)
	local btn = gohelper.findChildButtonWithAudio(obj, "#btn_suboption")
	local btnBg = gohelper.findChild(obj, "#btn_suboption/bg")
	local desc = gohelper.findChildTextMesh(obj, "#btn_suboption/#txt_suboption")
	local desc2 = gohelper.findChildTextMesh(obj, "#btn_suboption/#txt_suboption2")
	local condition = gohelper.findChildTextMesh(obj, "#btn_suboption/#txt_condition")
	local icon = gohelper.findChildImage(obj, "#image_icon")
	local gogray = gohelper.findChild(obj, "#btn_suboption_disable")
	local co = lua_sodache_choice.configDict[data]
	local isValid = SodacheOptionUtil.instance:checkOption(co.selectCond)

	if btnBg then
		ZProj.UGUIHelper.SetGrayscale(btnBg, not isValid)
	end

	if gogray then
		gohelper.setActive(gogray, not isValid)
	end

	local conditionStr = SodacheOptionUtil.instance:getOptionConditionStr(co.selectCond)

	if string.nilorempty(conditionStr) then
		desc.text = co.desc
		desc2.text = ""
		condition.text = ""
	else
		desc.text = ""
		desc2.text = co.desc
		condition.text = conditionStr
	end

	local iconName

	if not string.nilorempty(co.battleList) then
		iconName = "sodache_map_icon_2"
	elseif not string.nilorempty(co.verifyCond) then
		iconName = "sodache_map_icon_1"
	end

	if iconName then
		gohelper.setActive(icon, true)
		UISpriteSetMgr.instance:setSodache3Sprite(icon, iconName)
	else
		gohelper.setActive(icon, false)
	end

	self:removeClickCb(btn)
	self.addClickCb(self, btn, self._onClickBtn, self, {
		isValid = isValid,
		co = co
	})
end

function SodacheEventChoiceItem:_onClickBtn(data)
	if not data.isValid then
		GameFacade.showToast(ToastEnum.SodacheToastId373013)

		return
	end

	local co = data.co

	self._curChoiceCo = co

	if string.nilorempty(co.verifyCond) then
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.SelectChoice, tostring(co.id))
	elseif string.nilorempty(co.verifyCard) then
		ViewMgr.instance:openView(ViewName.SodacheCheckView, {
			choiceCo = co
		})
	else
		local isValid, cards = SodacheOptionUtil.instance:checkOption(co.verifyCard)

		if co.forceCard == 1 and (not isValid or not cards or not cards[1]) then
			logError("需要强制放牌，但是没有牌，无法检定！！！" .. co.id)
			GameFacade.showToast(ToastEnum.SodacheToastId373014)

			return
		end

		if co.autoCard == 1 then
			if cards then
				::label_5_0::

				local var_5_0 = cards[1]

				if cards[1] then
					local cardMo = cards[1]:toCardMo()

					ViewMgr.instance:openView(ViewName.SodacheCheckView, {
						choiceCo = co,
						cardMo = cardMo
					})
				end
			end
		else
			if cards and cards[1] then
				local selectMo = SodacheCardSelectMo.New()

				selectMo.selectCallobj = self
				selectMo.selectCallback = self.onSelectCardEnd

				selectMo:setCards(cards)

				selectMo.totalSelectCount = 1
				selectMo.choiceCo = co

				ViewMgr.instance:openView(ViewName.SodacheCardQuickSelectView, selectMo)

				return
			end

			ViewMgr.instance:openView(ViewName.SodacheCheckView, {
				choiceCo = co
			})
		end
	end
end

function SodacheEventChoiceItem:onSelectCardEnd(cardSelects)
	local cardId, num = next(cardSelects)

	if not cardId and self._curChoiceCo.forceCard == 1 then
		GameFacade.showToast(ToastEnum.SodacheToastId373014)

		return true
	end

	local cardMo = cardId and SodacheCardMo.Create(cardId)

	ViewMgr.instance:openView(ViewName.SodacheCheckView, {
		choiceCo = self._curChoiceCo,
		cardMo = cardMo
	})
end

return SodacheEventChoiceItem
