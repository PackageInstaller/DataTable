-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityColorEggMediator.lua

ActivityColorEggMediator = class("ActivityColorEggMediator", DmPopupViewMediator, _M)

ActivityColorEggMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}

function ActivityColorEggMediator:initialize()
	super.initialize(self)
end

function ActivityColorEggMediator:dispose()
	super.dispose(self)
end

function ActivityColorEggMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._animNode = self:getView():getChildByName("animNode")
	self._roleNode = self:getView():getChildByName("roleNode")
	self._tipsView = self:getView():getChildByName("Tips")

	self._tipsView:setVisible(false)
end

function ActivityColorEggMediator:enterWithData(data)
	self._data = data

	if self._data and self._data.effect then
		AudioEngine:getInstance():playEffect(self._data.effect, false)
	end

	self._callback = data.callback

	self:initView(data)
end

function ActivityColorEggMediator:initView(data)
	self._canTouch = 1

	if data then
		if data.anim then
			self._eggAnim = cc.MovieClip:create(data.anim.name)

			self._eggAnim:addTo(self._animNode):posite(data.anim.pos or cc.p(-440, -40))
			self._eggAnim:gotoAndPlay(data.anim.startFrame or 56)
			self._eggAnim:addCallbackAtFrame(data.anim.callbackFrame or 104, function()
				self:close({
					callback = self._callback
				})

				if self._callback then
					self._callback()
				end
			end)

			self._data.anim = self._eggAnim
		end

		if data.model and next(data.model) then
			if not data.model.Id then
				local modelId = "Model_ALPo"

				if not data.model.Type then
					local modelType = "Bust4"
					local scale = data.model.Scale and tonumber(data.model.Scale) or 0.8

					if data.model.UseAnim ~= nil then
						if not data.model.UseAnim then
							local useAnim = true
							local img, jsonPath = IconFactory:createRoleIconSpriteNew({
								frameId = "bustframe9",
								id = modelId,
								useAnim = useAnim
							})

							assert(img, "model not find..id.." .. modelId .. "......type......" .. modelType)
							img:addTo(self._roleNode):posite(0, 0)
							img:setScale(scale)

							if data.tips then
								self._tipsView:setVisible(true)

								local text = self._tipsView:getChildByFullName("text")
								local bg = self._tipsView:getChildByFullName("bg")

								text:setString(data.tips)

								local size = text:getContentSize()

								if size.height > 60 then
									bg:setContentSize(cc.size(text:getContentSize().width + 80, text:getContentSize().height + 80))
								end
							else
								self._tipsView:setVisible(false)
							end
						end
					end
				end
			end
		end
	end
end

function ActivityColorEggMediator:onTouchMaskLayer()
	if self._data and self._data.anim then
		if self._canTouch == 1 then
			self._canTouch = 2
		end

		if self._canTouch == 2 then
			self._canTouch = 3

			AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
			self._eggAnim:gotoAndPlay(self._data.anim.exitFrame or 99)
		end
	else
		self:close({
			callback = self._callback
		})
	end
end
