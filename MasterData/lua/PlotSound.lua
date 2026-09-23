--剧情音效
local currentPlotData
local infos

--角色音效
local lastKey = ""

--场景音效
local lastEffKeys = {}
local lastLoopKeys = {}

local lastEffKey = ""
local lastLoopKey = ""

function OnDisable()
	currentPlotData = nil
end

function PlaySound(data)
	currentPlotData = data
	PlayRoleSound(currentPlotData:GetSoundKey()) --人物语音
	
	StopEffSounds()
	infos = currentPlotData:GetEffSoundInfos()	
	if(infos) then --场景音效
		for i, v in ipairs(infos) do
			if(v.key) then
				local delay = v.delay or 0
				FuncUtil:Call(function()
					PlayEffSound(v)
				end, nil, delay * 1000)
			else
				LogError("音效中存在没key字段！剧情ID：" .. currentPlotData:GetID())
			end
		end
	end
end

function StopAllSound()
	if(not lastKey and #lastEffKeys <= 0 and #lastLoopKeys <= 0) then
		return
	end
	
	StopRoleSound(lastKey)
	StopLastSounds(true)
end

function GetSoundTime()
	if(currentPlotData) then
		local soundTime = currentPlotData:GetSoundTime() or 0 --默认0s
		local effTime = currentPlotData:GetEffSoundTime()
		soundTime = soundTime > effTime and soundTime or effTime
		
		return soundTime
	end
	return 0
end

function StopLastSounds(isClear)
	StopEffSounds()	
	StopEffSoundsByLoop()
end

---------------------------------角色音效-----------------------------------
function PlayRoleSound(key)
	if not key or key == "" then
		return
	end
	StopRoleSound(lastKey)
	CSAPI.PlayCfgSound(key, true)
	lastKey = key
end

function StopRoleSound(key)
	if _lastKey ~= "" then
		local cfg = Cfgs.Sound:GetByKey(_lastKey);
		if(cfg) then
			CSAPI.StopTargetSound(cfg.cue_sheet, cfg.cue_name)
			_lastKey = ""
		end
	end
end

---------------------------------场景音效-----------------------------------
function PlayEffSound(info)
	if(info.key == "none") then
		-- LogError("关闭所有循环音效!!!" .. table.tostring(lastLoopKeys))
		StopEffSoundsByLoop()
		return
	end	

	local _type = info.type or 1
	local cfgSound = Cfgs.PlotSound:GetByKey(info.key)
	local isLoop = cfgSound.loop == 1
	
	-- if((lastEffKey ~= "" and not isLoop) or(lastLoopKey ~= "" and isLoop)) then --停止播放上一个音效
	-- 	CSAPI.StopPlotSound(isLoop and lastLoopKey or lastEffKey)
	-- end
	local volume = info.volume or 100
	CSAPI.PlayPlotSound(info.key, false, volume)
	-- LogError("播放音效：" .. info.key .. "|isLoop:" .. tostring(isLoop))

	if(isLoop) then
		table.insert(lastLoopKeys, info.key)
		-- lastLoopKey = info.key
	else
		table.insert(lastEffKeys, info.key)
		-- lastEffKey = info.key
	end
end

function StopEffSounds()
	if(#lastEffKeys > 0) then
		for i, v in ipairs(lastEffKeys) do
			CSAPI.StopPlotSound(v)
		end
		lastEffKeys = {}
	end
end

function StopEffSoundsByLoop()	
	if(#lastLoopKeys > 0) then
		for i, v in ipairs(lastLoopKeys) do
			CSAPI.StopPlotSound(v)
		end
		lastLoopKeys = {}
	end
end

-- function PlayPlotSound(key, isloop, volumeCoeff, callBack)
-- 	local cfg = Cfgs.PlotSound:GetByKey(key);
-- 	if(not cfg) then
-- 		return;
-- 	end
-- 	local feature = false
-- 	CSAPI.PlaySound(cfg.cue_sheet, cfg.cue_name, isloop, feature, nil, 0.5, function()
-- 		if(callBack) then
-- 			callBack()
-- 		end
-- 	end, nil, volumeCoeff);
-- end
-- function StopPlotSound(_lastKey)
-- 	if _lastKey ~= "" then
-- 		local cfg = Cfgs.PlotSound:GetByKey(_lastKey)
-- 		if(cfg) then
-- 			CSAPI.StopTargetSound(cfg.cue_sheet, cfg.cue_name)
-- 		end
-- 	end
-- end 
