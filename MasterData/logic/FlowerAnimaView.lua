-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/view/FlowerAnimaView.lua

module("logic.extensions.sendflower.view.FlowerAnimaView", package.seeall)

local FlowerAnimaView = class("FlowerAnimaView", ViewComponent)

function FlowerAnimaView:ctor()
	FlowerAnimaView.super.ctor(self)
end

function FlowerAnimaView:unbindEvents()
	FlowerAnimaView.super.unbindEvents(self)
end

function FlowerAnimaView:bindEvents()
	FlowerAnimaView.super.bindEvents(self)
end

function FlowerAnimaView:buildUI()
	FlowerAnimaView.super.buildUI(self)

	self._effectGo = self:getGo("container/effect")
	self._itemGos = {
		self:getGo("container/item_1"),
		self:getGo("container/item_2")
	}
	self._txtContent = self:getTxt("container/txtContent")
end

function FlowerAnimaView:onExit()
	FlowerAnimaView.super.onExit(self)

	for i, item in ipairs(self._itemGos) do
		local imgHead = goutil.findChild(item, "imgHead")

		HeadItemController.instance:resetHeadCell(imgHead)
	end

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end
end

function FlowerAnimaView:onEnter()
	FlowerAnimaView.super.onEnter(self)

	local msgParams = self:getFirstParam()

	if not msgParams then
		self:close()

		return
	end

	local flowerId = msgParams.flowerId
	local flowerDefine = SendFlowerConfig.instance:getFlowerCfg(flowerId) or {}
	local flowerContent = flowerDefine.content
	local flowerName = ""

	if not string.nilorempty(flowerContent) then
		flowerName = MaterialMgr.getMaterialsNameByCfg(flowerContent) or ""
	end

	if not msgParams.num then
		local flowerCount = 0
		local totalValue = (flowerDefine.value or 0) * flowerCount

		if not msgParams.sdarea then
			if not msgParams.senderName then
				local senderName = ""

				if not msgParams.sdIcon then
					local senderHeadId = 0

					if not msgParams.sdFrm then
						local senderFrameId = 0

						if not msgParams.recvArea then
							local receiveZoneName = ""

							if not msgParams.receiveName then
								local receiveName = ""

								if not msgParams.recvIcon then
									local receiveHeadId = 0

									if not msgParams.recvFrm then
										local receiveFrameId = 0

										self._effectPath = string.format("%s.prefab", flowerDefine.mainEffPath)
										self._txtContent.text = langPara("%s%s给%s%s赠送了%d朵%s\n双方增加了%d魅力值", msgParams.sdarea, senderName, receiveZoneName, receiveName, flowerCount, flowerName, totalValue)

										self:_setUser(self._itemGos[1], msgParams.sdarea, senderName, senderHeadId, senderFrameId)
										self:_setUser(self._itemGos[2], receiveZoneName, receiveName, receiveHeadId, receiveFrameId)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function FlowerAnimaView:onEnterFinished()
	FlowerAnimaView.super.onEnterFinished(self)

	self._effect = UIEffectManager.instance:playEffect(self, self._effectPath, self._effectGo, 0, 0, false, nil, function()
		self:close()
	end, nil, self)

	self._effect:setEffTime(1.8)
	self._effect:setParent(self._effectGo.transform)
	self._effect:setLocalPos(0, 0, 0)
	self._effect:setScale(1)
end

function FlowerAnimaView:_setUser(item, zoneName, userName, headId, frameId)
	local imgHead = goutil.findChild(item, "imgHead")
	local txtServer = goutil.findChildTextComponent(item, "txtServer")
	local txtName = goutil.findChildTextComponent(item, "txtName")

	HeadItemController.instance:resetHeadCell(imgHead)

	if headId then
		HeadItemController.instance:setHeadCell(imgHead, headId, frameId)
	end

	txtServer.text = zoneName
	txtName.text = userName
end

return FlowerAnimaView
