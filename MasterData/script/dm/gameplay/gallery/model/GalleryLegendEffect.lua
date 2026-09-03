-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/model/GalleryLegendEffect.lua

GalleryLegendEffect = class("GalleryLegendEffect", objectlua.Object, _M)

GalleryLegendEffect:has("_id", {
	is = "rw"
})
GalleryLegendEffect:has("_currentNum", {
	is = "rw"
})
GalleryLegendEffect:has("_targetNum", {
	is = "rw"
})
GalleryLegendEffect:has("_targetHeroNum", {
	is = "rw"
})
GalleryLegendEffect:has("_desc", {
	is = "rw"
})
GalleryLegendEffect:has("_title", {
	is = "rw"
})
GalleryLegendEffect:has("_state", {
	is = "rw"
})

function GalleryLegendEffect:initialize(id)
	super.initialize(self)

	self._id = id
	self._state = false
	self._effect = nil
	self._condition = nil
	self._currentNum = 0
	self._targetNum = 0
	self._targetHeroNum = 0
	self._title = ""
	self._desc = ""
	self._translateId = ""
end

function GalleryLegendEffect:sync(data)
	if data.effect then
		self._effect = data.effect
	end

	if data.condition then
		self._condition = data.condition
	end

	if data.targetHeroNum then
		self._targetHeroNum = data.targetHeroNum
	end

	if data.translateId then
		self._translateId = data.translateId
	end

	self:initDesc()
end

function GalleryLegendEffect:initDesc()
	if self._title == "" then
		local star = 0

		if self._condition then
			star = self._condition.star
			self._targetNum = self._condition.star
		else
			self._targetNum = self._targetHeroNum
		end

		self._title = Strings:get(self._translateId, {
			fontName = TTF_FONT_FZYH_R,
			num = self._targetHeroNum,
			star = star
		})
	end

	if self._desc == "" then
		local effectIds = self._effect.attr
		local skillIds = self._effect.skill
		local desc = ""

		if effectIds then
			for i = 1, #effectIds do
				local effectId = effectIds[i]

				desc = desc == "" and SkillPrototype:getAttrEffectDesc(effectId, 1) or desc .. "\n" .. SkillPrototype:getAttrEffectDesc(effectId, 1)
			end
		end

		if skillIds then
			for i = 1, #skillIds do
				local skillId = skillIds[i]

				if desc == "" then
					local title = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc")

					desc = ConfigReader:getEffectDesc("Skill", title, skillId, 1, {})
				else
					local title = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc")
					local desc_ = ConfigReader:getEffectDesc("Skill", title, skillId, 1, {})

					desc = desc .. "\n" .. desc_
				end
			end
		end

		self._desc = desc
	end
end
