-- chunkname: @modules/logic/ressplit/work/ResSplitAudioWemWork.lua

module("modules.logic.ressplit.work.ResSplitAudioWemWork", package.seeall)

local ResSplitAudioWemWork = class("ResSplitAudioWemWork", BaseWork)

function ResSplitAudioWemWork:onStart(context)
	local file = io.open("../audios/Android/SoundbanksInfo.xml", "r")
	local xml = file:read("*a")

	file:close()

	local parser = ResSplitXml2lua.parser(ResSplitXmlTree)

	parser:parse(xml)
	ResSplitModel.instance:setExclude(ResSplitEnum.AudioWem, "ResSplitAudioWemWork_temp", false)

	local innerBGM = {}

	for _, item in ipairs(lua_bg_audio.configList) do
		if innerBGM[item.bankName] == nil then
			innerBGM[item.bankName] = {}
		end

		table.insert(innerBGM[item.bankName], item)
	end

	self.bank2wenDic = {}
	self.bankEvent2wenDic = {}
	self.wen2BankDic = {}

	for i, p in pairs(ResSplitXmlTree.root.SoundBanksInfo.SoundBanks.SoundBank) do
		self:_dealSingleSoundBank(p)
	end

	local excludeDic = ResSplitModel.instance:getExcludeDic(ResSplitEnum.CommonAudioBank)

	for bankName, v in pairs(excludeDic) do
		if v == true then
			if self.bank2wenDic[bankName] then
				for n, fileId in pairs(self.bank2wenDic[bankName]) do
					self.wen2BankDic[fileId][bankName] = nil
				end
			end

			innerBGM[bankName] = nil
		end
	end

	local excludeWenDic = {}

	for fileId, v in pairs(self.wen2BankDic) do
		if tabletool.len(v) == 0 then
			ResSplitModel.instance:setExclude(ResSplitEnum.AudioWem, fileId, true)

			excludeWenDic[fileId] = true
		end
	end

	local defaultBGMDic = {
		[AudioEnum.Default_UI_Bgm] = true,
		[AudioEnum.Default_UI_Bgm_Stop] = true,
		[AudioEnum.Default_Fight_Bgm] = true,
		[AudioEnum.Default_Fight_Bgm_Stop] = true,
		[AudioEnum.UI.Play_Login_interface_nosie] = true,
		[AudioEnum.UI.Stop_Login_interface_noise] = true,
		[AudioEnum.UI.Play_Login_interface_noise_1_9] = true,
		[AudioEnum.UI.Stop_Login_interface_noise_1_9] = true
	}

	for _, itemList in pairs(innerBGM) do
		for _, item in pairs(itemList) do
			if item then
				if self.bank2wenDic[item.bankName] then
					for n, fileId in pairs(self.bank2wenDic[item.bankName]) do
						if excludeWenDic[fileId] == nil then
							ResSplitModel.instance:setExclude(ResSplitEnum.InnerAudioWem, fileId, defaultBGMDic[item.id] ~= true)
						end
					end
				end
			end
		end
	end

	self:_dealActivitySoundBank()
	self:onDone(true)
end

function ResSplitAudioWemWork:_dealActivitySoundBank()
	local arr = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/../../../audios/iOS/", false)
	local activtiyBankList = {}

	for i = 0, arr.Length - 1 do
		local path = arr[i]

		if string.find(path, "ui_activity", 1, true) == 1 or string.find(path, "activity", 1, true) then
			local fileName = SLFramework.FileHelper.GetFileName(path, false)

			table.insert(activtiyBankList, fileName)
		end
	end

	for i, bankName in ipairs(activtiyBankList) do
		ResSplitModel.instance:setExclude(ResSplitEnum.CommonAudioBank, bankName, true)

		local fileIds = self.bank2wenDic[bankName]

		if fileIds then
			for n, fileId in ipairs(fileIds) do
				ResSplitModel.instance:setExclude(ResSplitEnum.AudioWem, fileId, true)
			end
		end
	end
end

function ResSplitAudioWemWork:_dealSingleSoundBank(soundBank)
	local bankName = soundBank.ShortName

	if soundBank._attr.Language == "SFX" and soundBank.Media then
		for i, mediaFile in pairs(soundBank.Media.File) do
			if mediaFile.Path then
				self:_addWenInfo(bankName, "", mediaFile.Path)
			end
		end
	end
end

function ResSplitAudioWemWork:_addWenInfo(bankName, eventName, fileId)
	if self.bank2wenDic[bankName] == nil then
		self.bank2wenDic[bankName] = {}
	end

	table.insert(self.bank2wenDic[bankName], fileId)

	local eventKey = bankName .. "#" .. eventName

	if self.bankEvent2wenDic[eventKey] == nil then
		self.bankEvent2wenDic[eventKey] = {}
	end

	table.insert(self.bankEvent2wenDic[eventKey], fileId)

	if self.wen2BankDic[fileId] == nil then
		self.wen2BankDic[fileId] = {}
	end

	self.wen2BankDic[fileId][bankName] = true
end

return ResSplitAudioWemWork
