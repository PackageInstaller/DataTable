-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191GetView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191GetView", package.seeall)

local Act191GetView = class("Act191GetView", BaseView)

function Act191GetView:onInitView()
	self._scrollGet = gohelper.findChildScrollRect(self.viewGO, "#scroll_Get")
	self._goHeroRoot = gohelper.findChild(self.viewGO, "#scroll_Get/Viewport/Content/#go_HeroRoot")
	self._goHero = gohelper.findChild(self.viewGO, "#scroll_Get/Viewport/Content/#go_HeroRoot/#go_Hero")
	self._goCollectionRoot = gohelper.findChild(self.viewGO, "#scroll_Get/Viewport/Content/#go_CollectionRoot")
	self._goCollection = gohelper.findChild(self.viewGO, "#scroll_Get/Viewport/Content/#go_CollectionRoot/collectionitem/#go_Collection")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191GetView:onClickModalMask()
	self:closeThis()
end

function Act191GetView:_editableInitView()
	self.actInfo = Activity191Model.instance:getActInfo()
	self.touchGraphic = self._scrollGet.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic))
end

function Act191GetView:onOpen()
	self.gameInfo = self.viewParam or self.actInfo:getGameInfo()

	local heroIdCntDic = {}
	local itemIdCntDic = {}

	for _, v in ipairs(self.actInfo.triggerEffectPushList) do
		if v.effectId[1] and not string.nilorempty(v.param) then
			local effectCo = lua_activity191_effect.configDict[v.effectId[1]]

			if effectCo then
				local insertTbl

				if tabletool.indexOf(Activity191Enum.EffectGetHero, effectCo.type) then
					insertTbl = heroIdCntDic
				elseif tabletool.indexOf(Activity191Enum.EffectGetItem, effectCo.type) then
					insertTbl = itemIdCntDic
				end

				if insertTbl then
					local list = cjson.decode(v.param)

					for _, id in ipairs(list) do
						insertTbl[id] = insertTbl[id] and insertTbl[id] + 1 or 1
					end
				end
			end
		end
	end

	local heroCoList = {}
	local itemCoList = {}

	for id, _ in pairs(heroIdCntDic) do
		heroCoList[#heroCoList + 1] = Activity191Config.instance:getRoleCo(id)
	end

	for id, _ in pairs(itemIdCntDic) do
		itemCoList[#itemCoList + 1] = Activity191Config.instance:getCollectionCo(id)
	end

	for i = 1, #heroCoList do
		local heroCo = heroCoList[i]
		local go = gohelper.cloneInPlace(self._goHero)
		local parent = gohelper.findChild(go, "head")
		local headGo = self:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, parent)
		local headItem = MonoHelper.addNoUpdateLuaComOnceToGo(headGo, Act191HeroHeadItem, {
			exSkill = true
		})

		headItem:setData(nil, heroCo.id)

		local goLvlUp = gohelper.findChild(go, "go_lvlup")
		local heroInfo = self.gameInfo:getHeroInfoInWarehouse(heroCo.roleId)
		local lvlChange = 0

		if heroInfo then
			local getCnt = heroIdCntDic[heroCo.id]

			lvlChange = heroInfo.star ~= getCnt and getCnt or getCnt - 1
		end

		gohelper.setActive(goLvlUp, lvlChange ~= 0)

		local attrCo = lua_activity191_template.configDict[heroCo.id]
		local txtColor = lvlChange == 0 and "#C3AA87" or "#E27444"

		for j = 1, 5 do
			if j ~= 3 then
				local attributeGo = gohelper.findChild(go, "go_attribute/attribute" .. j)
				local txtArr = gohelper.findChildText(attributeGo, "txt_attribute")
				local goup = gohelper.findChild(attributeGo, "txt_attribute/go_up")

				gohelper.setActive(goup, lvlChange ~= 0)

				local txtArrName = gohelper.findChildText(attributeGo, "name")
				local attrId = Activity191Enum.AttrIdList[j]
				local attrValue = attrCo[Activity191Config.AttrIdToFieldName[attrId]]

				txtArr.text = string.format("<color=%s>%s</color>", txtColor, attrValue)
				txtArrName.text = HeroConfig.instance:getHeroAttributeCO(attrId).name
			end
		end

		local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

		self.addClickCb(self, btnClick, self.onClickHero, self, heroCo.id)
	end

	for i = 1, #itemCoList do
		local collectionCo = itemCoList[i]

		for j = 1, itemIdCntDic[collectionCo.id] do
			local go = gohelper.cloneInPlace(self._goCollection)
			local imageRare = gohelper.findChildImage(go, "image_Rare")

			UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_propitembg_" .. collectionCo.rare)

			local collectionIcon = gohelper.findChildSingleImage(go, "simage_Icon")

			collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(collectionCo.icon))

			local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

			self.addClickCb(self, btnClick, self.onClickCollection, self, collectionCo.id)
		end
	end

	gohelper.setActive(self._goHero, false)
	gohelper.setActive(self._goCollection, false)
	gohelper.setActive(self._goHeroRoot, #heroCoList ~= 0)
	gohelper.setActive(self._goCollectionRoot, #itemCoList ~= 0)

	self.touchGraphic.raycastTarget = #heroCoList > 2
end

function Act191GetView:onClose()
	self.actInfo:clearTriggerEffectPush()
	Activity191Controller.instance:nextStep()
end

function Act191GetView:onClickHero(id)
	local param = {
		heroList = {
			id
		}
	}

	Activity191Controller.instance:openHeroTipView(param)
end

function Act191GetView:onClickCollection(id)
	Activity191Controller.instance:openCollectionTipView({
		itemId = id
	})
end

return Act191GetView
