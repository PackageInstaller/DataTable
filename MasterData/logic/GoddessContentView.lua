-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/view/GoddessContentView.lua

module("logic.extensions.goddessdelicacy.view.GoddessContentView", package.seeall)

local GoddessContentView = class("GoddessContentView", ViewComponent)

function GoddessContentView:ctor()
	GoddessContentView.super.ctor(self)

	self._materialGoList = nil
end

function GoddessContentView:bindEvents()
	GoddessContentView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sharBtn:AddClickListener(function()
		if self._paramInfo and self._paramInfo.activityId then
			if self._paramInfo.stage ~= GoddessDelicacyController.instance.unLockFinish then
				FloatWordMgr.instance:show("礼物配方还未解锁哦~")

				return
			end

			UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.ShareFood, self._paramInfo.activityId, self._paramInfo.dishId)
		end

		self:close()
	end, self)
end

function GoddessContentView:unbindEvents()
	GoddessContentView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sharBtn:RemoveClickListener()
end

function GoddessContentView:destroyUI()
	GoddessContentView.super.destroyUI(self)
	uGuiUtil.clearImage(self._goodsGo)

	for _, item in pairs(self._materialGoList or {}) do
		if item and item.matGo then
			uGuiUtil.clearImage(item.matGo)
		end
	end

	self._materialGoList = nil
end

function GoddessContentView:buildUI()
	GoddessContentView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._closeBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "closeBtn")
	self._nameTxt = goutil.findChildTextComponent(viewBgGo, "nameGo/nameTxt")
	self._levelIma = goutil.findChild(viewBgGo, "nameGo/nameTxt/levelIma"):GetComponent("UIImageSpriteChange")
	self._goodsGo = goutil.findChild(viewBgGo, "goodsGo")
	self._sharBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "sharBtn")
	self._descTxt = goutil.findChildTextComponent(viewBgGo, "tableview/Viewport/Content/descTxt")
	self._materialGoList = {}

	local materialGo = goutil.findChild(viewBgGo, "materialGo_1")

	self._materialGoList[1] = {
		itemGo = materialGo,
		matGo = goutil.findChild(materialGo, "matGo"),
		unknownGo = goutil.findChild(materialGo, "unknownGo"),
		matTxt = goutil.findChildTextComponent(materialGo, "matTxt")
	}
	materialGo = goutil.findChild(viewBgGo, "materialGo_2")
	self._materialGoList[2] = {
		itemGo = materialGo,
		matGo = goutil.findChild(materialGo, "matGo"),
		unknownGo = goutil.findChild(materialGo, "unknownGo"),
		matTxt = goutil.findChildTextComponent(materialGo, "matTxt")
	}
	materialGo = goutil.findChild(viewBgGo, "materialGo_3")
	self._materialGoList[3] = {
		itemGo = materialGo,
		matGo = goutil.findChild(materialGo, "matGo"),
		unknownGo = goutil.findChild(materialGo, "unknownGo"),
		matTxt = goutil.findChildTextComponent(materialGo, "matTxt")
	}
	materialGo = goutil.findChild(viewBgGo, "materialGo_4")
	self._materialGoList[4] = {
		itemGo = materialGo,
		matGo = goutil.findChild(materialGo, "matGo"),
		unknownGo = goutil.findChild(materialGo, "unknownGo"),
		matTxt = goutil.findChildTextComponent(materialGo, "matTxt")
	}
	self._nameTxt.text = ""
	self._descTxt.text = ""

	GameUtil.SetActive(self._materialGoList[1].unknownGo, false)

	self._materialGoList[1].matTxt.text = ""

	GameUtil.SetActive(self._materialGoList[2].unknownGo, false)

	self._materialGoList[2].matTxt.text = ""

	GameUtil.SetActive(self._materialGoList[3].unknownGo, false)

	self._materialGoList[3].matTxt.text = ""

	GameUtil.SetActive(self._materialGoList[4].unknownGo, false)

	self._materialGoList[4].matTxt.text = ""
end

function GoddessContentView:onEnter()
	GoddessContentView.super.onEnter(self)

	self._paramInfo = self:getFirstParam()

	if self._paramInfo == nil then
		printError("sr---超神龙召唤   GoddessContentView:onEnter()      未传参数！！！")

		return
	end

	uGuiUtil.setSpriteToImage(self._goodsGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._paramInfo.icon))

	self._nameTxt.text = self._paramInfo.name
	self._descTxt.text = self._paramInfo.desc

	self._levelIma:SetState(self._paramInfo.idsCount - 2)
	self:_showAllFoodsItem()
end

function GoddessContentView:_showAllFoodsItem()
	if self._paramInfo.foodIds then
		if not #self._paramInfo.foodIds then
			local count = 0

			for i = 1, count do
				if self._materialGoList[i] and self._materialGoList[i].itemGo then
					GameUtil.SetActive(self._materialGoList[i].itemGo, true)
					uGuiUtil.clearImage(self._materialGoList[i].matGo)

					if self._paramInfo.stage == GoddessDelicacyController.instance.unLockFinish then
						local cfg = GoddessDelicacyConfig.instance:getNotesFoodCfg(self._paramInfo.activityId, self._paramInfo.foodIds[i])

						if cfg == nil then
							self._materialGoList[i].matTxt.text = ""

							GameUtil.SetActive(self._materialGoList[i].unknownGo, true)
						else
							GameUtil.SetActive(self._materialGoList[i].unknownGo, false)

							self._materialGoList[i].matTxt.text = cfg.name

							uGuiUtil.setSpriteToImage(self._materialGoList[i].matGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))
						end
					else
						self._materialGoList[i].matTxt.text = ""

						GameUtil.SetActive(self._materialGoList[i].unknownGo, true)
					end
				end
			end

			if self._materialGoList and count < #self._materialGoList then
				for i = count + 1, #self._materialGoList do
					if self._materialGoList[i] and self._materialGoList[i].itemGo then
						uGuiUtil.clearImage(self._materialGoList[i].matGo)
						GameUtil.SetActive(self._materialGoList[i].itemGo, false)
					end
				end
			end
		end
	end
end

return GoddessContentView
