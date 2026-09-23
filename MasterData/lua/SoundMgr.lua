--声音管理
SoundMgr = {};
local this = SoundMgr;

--播放声音
--name：声音名称
--packName：声音包名
--time：时间（毫秒）
--loop：是否循环
--fadeTime：渐变时间
--volume：音量
function this:Play(name, packName, time, loop, fadeTime, volume)
	time = time or - 1;
	if(loop == nil) then
		loop = false;
	end
	fadeTime = fadeTime or 0;
	volume = volume or 1;
	
	return self:GetMgr():Play(name, packName, time, loop, fadeTime, volume);
end

function this:GetMgr()
	if(self.mgr == nil) then
		self.mgr = CS.SoundMgr.ins;
	end
	return self.mgr;
end


--播放背景音乐
function this:PlayBGM(bgmName)
	if(self.currBGM) then
		if(bgmName and bgmName == self.currBGMName) then
			return;
		else
			self:StopBGM();
		end
	end
	
	if(bgmName) then
		self.currBGMName = bgmName;
		self.currBGM = self:Play(bgmName, bgmName, - 1, true, 2000, SoundMgr:GetValue(s_audio_scale.music));	
	end
end

--停止背景音乐
function this:StopBGM()
	if(self.currBGM) then
		self.currBGM:Stop(2000);
		self.currBGM = nil;
		self.currBGMName = nil;
	end
end

--播放界面音效
function this:PlayUI(name, uiPackName)
	uiPackName = uiPackName or "UI";
	if(name) then	
		self:Play(name, uiPackName, nil, nil, nil, SoundMgr:GetValue(s_audio_scale.sound));	
	end
end



function this:GetLanguageCVs(language)
    local targetCfgs = {};

    local cfgs = Cfgs.SoundLanguage:GetAll();
    for _,cfg in pairs(cfgs)do
       if(cfg.language == language)then
           table.insert(targetCfgs,cfg);
       end 
    end

    --LogError(targetCfgs);
    return targetCfgs;
end

function this:NeedDownloadLanguageCVs(language)
    local cfgs = self:GetLanguageCVs(language);
    if(cfgs)then
       for _,cfg in ipairs(cfgs)do
          local cvName = cfg.cue_sheet;
          if(not CSAPI.IsDownloadedCV(cvName,language))then
             return true;
          end   
       end     
    end    
end

function this:SetAllLanguageCVs(language)
    local cfgs = self:GetLanguageCVs(language);
    if(cfgs)then
       for _,cfg in ipairs(cfgs)do
          local cvName = cfg.cue_sheet;
          self:SetLanguageCV(cvName,language);          
       end     
    end    
end
function this:ResetAllLanguageCV()
    CSAPI.ResetAllLanguage();
    self.languageCVs = {};
    self:SaveLanguageCV();
end

local languageCVFile = "language_cv";
function this:InitLanguageCV()
    local data = FileUtil.LoadByPath(languageCVFile);
    --LogError(data);
    if(data)then
        for cvName,language in pairs(data)do
            self:SetLanguageCV(cvName,language,true);
        end
    end
end
function this:SaveLanguageCV()
    local data = self.languageCVs or {};
    FileUtil.SaveToFile(languageCVFile,data);
end



function this:SetLanguageCV(cvName,language,dontSave)
    self.languageCVs = self.languageCVs or {};
    self.languageCVs[cvName] = language;    

    if(StringUtil:IsEmpty(language))then
        CSAPI.SetCVLanguage(cvName,"");
        return;
    end
    if(CSAPI.IsDownloadedCV(cvName,language))then
        CSAPI.SetCVLanguage(cvName,language);
        --LogError("已下载");
    else
        self.downloading = self.downloading or {};
        local cvKey = cvName .. language;
        if(self.downloading and self.downloading[cvKey])then
            return;
        end
        self.downloading[cvKey] = 1;
        --LogError("开始下载");
        CSAPI.DownloadCV(cvName,language,function()
            self.downloading[cvKey] = nil;
            if(CSAPI.IsDownloadedCV(cvName,language))then
                CSAPI.SetCVLanguage(cvName,language);  
                --LogError("完成");
            else
                --LogError("下载出错");
                Tips.ShowTips("下载角色语言失败！请确保网络正常后重试");
            end            
        end);
    end

    if(not dontSave)then
        self:SaveLanguageCV();
    end
end

function this:GetCVLanguage(cvName)
    return self.languageCVs and self.languageCVs[cvName]
end

--==============================--
--desc: 刷新音量大小（在设置面板改变）
--time:2019-09-11 11:14:42
--@args:
--@return 
--==============================--
function this:RefreshBGMVolume(value)
    if(self.currBGM) then
        self.currBGM:RefreshVolume(value)
    end
end

return this; 