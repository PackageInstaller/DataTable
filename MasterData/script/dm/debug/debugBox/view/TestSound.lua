-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/TestSound.lua

TestSound = class("TestSound", DebugViewTemplate, _M)

function TestSound:initialize()
	self._viewConfig = {
		{
			default = "ZTXChang",
			name = "heroId",
			title = "填写英雄ID",
			type = "Input"
		},
		{
			default = 0,
			name = "soundIndex",
			title = "填写语音编号",
			type = "Input"
		},
		{
			default = 0,
			name = "use_0",
			title = "循环时十位补零,是1,否0",
			type = "Input"
		}
	}
	self._playing = false
	self._useIndex = false
	self._soundIndex = 1
	self._boardHeroEffect = nil
	self._use_0 = false
end

function TestSound:onClick(data)
	local heroId = data.heroId

	self._useIndex = false
	self._use_0 = false

	if self._roleEffect then
		AudioEngine:getInstance():stopEffect(self._roleEffect)

		self._roleEffect = nil
	end

	if tonumber(data.use_0) > 0 then
		self._use_0 = true
	end

	if data.soundIndex and data.soundIndex ~= "" and data.soundIndex ~= "0" then
		self._useIndex = true
		self._soundIndex = data.soundIndex
	else
		self._soundIndex = tonumber(data.soundIndex)

		if self._soundIndex <= 0 then
			self._soundIndex = 1
		end
	end

	if not heroId or heroId == "" then
		return
	end

	self:playSound(heroId)
end

function TestSound:playSound(heroId)
	local soundId = "Voice_" .. heroId .. "_" .. self._soundIndex

	if self._useIndex == false then
		if self._use_0 and self._soundIndex < 10 then
			soundId = "Voice_" .. heroId .. "_0" .. self._soundIndex
		end

		if self._soundIndex > 70 then
			return
		end
	end

	if self:checkIsSoundExist(soundId) then
		self._playing = true

		print("--------->正在播放" .. "soundId----->" .. soundId)

		self._roleEffect = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
			self._playing = false

			if self._useIndex == false then
				self._soundIndex = self._soundIndex + 1

				self:playSound(heroId)
			end
		end)
	else
		print("-------->没有相关配置" .. "soundId----->" .. soundId)

		if self._useIndex == false then
			self._soundIndex = self._soundIndex + 1

			self:playSound(heroId)
		end
	end
end

function TestSound:checkIsSoundExist(soundId)
	return (ConfigReader:getRecordById("Sound", soundId) ~= nil or nil) and true
end
