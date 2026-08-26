-- chunkname: @modules/logic/ressplit/work/save/ResSplitSaveAudioWemWork.lua

module("modules.logic.ressplit.work.save.ResSplitSaveAudioWemWork", package.seeall)

local ResSplitSaveAudioWemWork = class("ResSplitSaveAudioWemWork", BaseWork)

function ResSplitSaveAudioWemWork:onStart(context)
	local file = io.open("../audios/Android/SoundbanksInfo.xml", "r")
	local xml = file:read("*a")

	file:close()

	local parser = ResSplitXml2lua.parser(ResSplitXmlTree)

	parser:parse(xml)
	ResSplitModel.instance:setInclude(ResSplitEnum.AudioWem, "ResSplitAudioWemWork_temp", false)

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

	local includeDic = ResSplitModel.instance:getIncludeDic(ResSplitEnum.CommonAudioBank)

	if includeDic then
		for bankName, v in pairs(includeDic) do
			if v == true then
				if self.bank2wenDic[bankName] then
					for n, fileId in pairs(self.bank2wenDic[bankName]) do
						self.wen2BankDic[fileId][bankName] = nil
					end
				end

				innerBGM[bankName] = nil
			end
		end
	end

	local includeWenDic = {}

	for fileId, v in pairs(self.wen2BankDic) do
		if tabletool.len(v) == 0 then
			ResSplitModel.instance:setInclude(ResSplitEnum.AudioWem, fileId)

			includeWenDic[fileId] = true
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
				local eventKey = item.bankName .. "#" .. item.eventName

				if self.bankEvent2wenDic[eventKey] then
					for n, fileId in pairs(self.bankEvent2wenDic[eventKey]) do
						if includeWenDic[fileId] == nil and defaultBGMDic[item.id] == true then
							ResSplitModel.instance:setInclude(ResSplitEnum.InnerAudioWem, fileId)
						end
					end
				end
			end
		end
	end

	self:onDone(true)
end

function ResSplitSaveAudioWemWork:_dealSingleSoundBank(soundBank)
	local bankName = soundBank.ShortName

	if soundBank._attr.Language == "SFX" and soundBank.IncludedEvents then
		for i, event in pairs(soundBank.IncludedEvents.Event) do
			local eventName = event._attr.Name

			if event.ReferencedStreamedFiles then
				for n, file in pairs(event.ReferencedStreamedFiles.File) do
					self:_addWenInfo(bankName, eventName, file._attr.Id)
				end
			end
		end
	end
end

function ResSplitSaveAudioWemWork:_addWenInfo(bankName, eventName, fileId)
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

return ResSplitSaveAudioWemWork
