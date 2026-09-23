local isOpening=false;
local voiceCfgs=nil;--音效表配置
local playingIdx=nil;--播放中的下标，为nil时则没播放
local currSkin=nil;
local isBuy=false;

function OnOpen()
    PlayEnter();
    if data then
        currSkin=ShopCommFunc.GetSkinInfo(data);
        local curModelCfg=currSkin:GetModelCfg();
        local rSkinInfo=RoleSkinMgr:GetRoleSkinInfo(curModelCfg.role_id,curModelCfg.id);
        if data and (data:IsOver() or (rSkinInfo and rSkinInfo:CheckCanUse() == true )) then
            isBuy=true;
        else
            isBuy=false;
        end
        local spTips=currSkin:GetShowTips(isBuy);
        CSAPI.SetText(txtContent,spTips or "");
        local list=currSkin:UnlockVoice();
        local tips2=nil;
        if list then
            voiceCfgs={};
            for k, v in ipairs(list) do
                local voiceCfg=Cfgs.Sound:GetByID(v);
                local name=""
                if voiceCfg~=nil then
                    if k<=2 then
                        SetItemStyle(k,voiceCfg)
                    end
                    table.insert(voiceCfgs,voiceCfg);
                    local model2=Cfgs.character:GetByID(voiceCfg.model);
                    name=model2.key
                    --初始化子物体
                    if tips2==nil then
                        local isSkin=model2.skin~=nil;
                        if isSkin then
                            tips2=LanguageMgr:GetByID(18209,name,model2.desc);
                        else
                            tips2=LanguageMgr:GetByID(18210,name);
                        end
                    end
                end
            end
        end
        CSAPI.SetText(txtContent2,tips2);
    end
end

function OnDestroy()
    RoleAudioPlayMgr:StopSound()
    playingIdx=nil;
end

function SetItemStyle(idx,cfg)
    local state=3;--锁定
    if cfg and idx then
        CSAPI.SetGOActive(this["item"..idx],true);
        if playingIdx==idx then
            state=2;--播放中
        elseif isBuy or idx==1 then
            state=1;--已解锁未播放
        end              
        local str=SettingMgr:GetSoundScript(cfg);
        CSAPI.SetText(this["txtDesc"..idx],str);
    elseif idx then
        CSAPI.SetGOActive(this["item"..idx],false);
    end
    CSAPI.LoadImg(this["item"..idx],"UIs/ShopSkinPage/img_34_"..state..".png",true,nil,true);
    CSAPI.LoadImg(this["icon"..idx],"UIs/ShopSkinPage/btn_08_0"..state..".png",true,nil,true);
    CSAPI.SetTextColorByCode(this["txtDesc"..idx],state==2 and "ffc146" or "ffffff")
end

function PlayEnter()
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.SetAnchor(node,0,-500)
    CSAPI.ApplyAction(node, "View_Open_Fade");
    UIUtil:DoLocalMove(node, {0,0,0},function()
        isOpening=false;
    end)
end

function PlayOut(func)
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.ApplyAction(node, "View_Close_Fade2");
    UIUtil:DoLocalMove(node, {0,-500,0},func)
end

function Close()
    if isOpening then
        do
            return
        end
    end
    PlayOut(function()
        if not IsNil(view) then
            isOpening=false;
            view:Close(); 
        end
    end);
end

function OnClickClose()
    Close();
end

---判断检测是否按了返回键
function CheckVirtualkeys()
    --仅仅安卓或者苹果平台生效
    if IsMobileplatform then
        if(Input.GetKeyDown(KeyCode.Escape))then
            if CSAPI.IsBeginnerGuidance()==false then
                Close();
            end
        end
    end
end

function OnClickIcon1()
    if playingIdx==1 then
        do return end;
    end
    PlaySound(1)
end

function OnClickIcon2()
    if isBuy~=true or playingIdx==2 then
        do return end;
    end
    PlaySound(2)
end

function PlaySound(idx)
    RoleAudioPlayMgr:StopSound()
    playingIdx=nil;
    local cfg=nil
    if voiceCfgs and voiceCfgs[idx]~=nil then
        cfg=voiceCfgs[idx];
    else
        do return end
    end
    --播放对应语音
    if (not RoleAudioPlayMgr:GetIsPlaying()) then
        playingIdx=idx;
        RoleAudioPlayMgr:Play(cfg, PlayCB, EndCB)
    end
end

function PlayCB()
    if playingIdx==nil or (voiceCfgs==nil or (voiceCfgs~=nil and voiceCfgs[playingIdx]==nil)) then
        do return end;
    end
    SetItemStyle(playingIdx,voiceCfgs[playingIdx])
end

function EndCB()
    if playingIdx==nil or (voiceCfgs==nil or (voiceCfgs~=nil and voiceCfgs[playingIdx]==nil)) then
        do return end;
    end
    local tempIdx=playingIdx
    playingIdx=nil;
    SetItemStyle(tempIdx,voiceCfgs[tempIdx])
end