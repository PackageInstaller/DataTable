-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassWidget.lua

KPassVoiceType = {
	soldout = 3,
	begin = 1,
	buyEnd = 2
}
PassSpineTalkVoice = class("PassSpineTalkVoice", objectlua.Object, _M)

function PassSpineTalkVoice:initialize(passSystem)
	super.initialize(self)

	self._passSystem = passSystem

	self:initMember()
	self:prepareForData()
end

function PassSpineTalkVoice:initMember()
	return
end

function PassSpineTalkVoice:prepareForData()
	self._allData = {}
	self._allData[1] = self._passSystem:getPassModelTalkVoiceData(1)
	self._allData[2] = self._passSystem:getPassModelTalkVoiceData(2)
end

function PassSpineTalkVoice:addSpine(view, viewType)
	self:createRoleIconSprite(view, viewType)
end

function PassSpineTalkVoice:createRoleIconSprite(view, viewType)
	local oneData = self._allData[viewType]

	if oneData ~= nil then
		local roleModel = oneData.ModelId

		if roleModel == "Model_SDTZ_Shop" then
			local animPath = "asset/anim/portraitpic_SDTZ_Shop.skel"

			if cc.FileUtils:getInstance():isFileExist(animPath) then
				self._spineNode = sp.SkeletonAnimation:create(animPath)

				self._spineNode:playAnimation(0, "SDTZ_Shop_Action1", true)
				self._spineNode:addTo(view):posite(0, -500)
				self._spineNode:setScale(0.4)
				self._spineNode:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_COMPLETE)

				if oneData.position and #oneData.position == 2 then
					self._spineNode:setPosition(cc.p(oneData.position[1], oneData.position[2]))
				end

				if oneData.scale then
					self._spineNode:setScale(oneData.scale[1])
				end
			end
		else
			local heroSprite = IconFactory:createRoleIconSpriteNew({
				useAnim = true,
				iconType = 2,
				id = roleModel
			})

			heroSprite:addTo(view)
			heroSprite:setScale(0.8)
			heroSprite:setPosition(cc.p(0, 0))

			if oneData.position and #oneData.position == 2 then
				heroSprite:setPosition(cc.p(oneData.position[1], oneData.position[2]))
			end

			if oneData.scale then
				heroSprite:setScale(oneData.scale[1])
			end
		end
	end
end

function PassSpineTalkVoice:spineAnimEvent(event)
	if event.animation == "SDTZ_Shop_Action1" and event.type == "complete" then
		self._spineNode:playAnimation(0, "SDTZ_Shop_Stand1", true)
	end
end

function PassSpineTalkVoice:playVoice(viewType, passVoiceType)
	local oneData = self._allData[viewType]

	if oneData ~= nil then
		local playVoice = ""

		if passVoiceType == KPassVoiceType.begin and oneData.inVoice ~= nil then
			playVoice = oneData.inVoice[1]
		end

		if passVoiceType == KPassVoiceType.buyEnd and oneData.buyVoice ~= nil then
			local index = math.random(1, #oneData.buyVoice)

			playVoice = oneData.buyVoice[index] or oneData.buyVoice[1]
		end

		if passVoiceType == KPassVoiceType.soldout and oneData.soldOutVoice ~= nil then
			playVoice = oneData.soldOutVoice[1]
		end

		if playVoice and playVoice ~= "" then
			self:stopEffect()

			self._heroEffect, _ = AudioEngine:getInstance():playEffect(playVoice, false)
		end

		local soundDesc = ConfigReader:getDataByNameIdAndKey("Sound", playVoice, "SoundDesc")

		return (soundDesc ~= nil or nil) and Strings:get(soundDesc)
	end
end

function PassSpineTalkVoice:stopEffect()
	AudioEngine:getInstance():stopEffect(self._heroEffect)
end
