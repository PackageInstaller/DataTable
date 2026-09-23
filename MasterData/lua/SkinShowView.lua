--皮肤展示界面
local roleItem=nil;
local effect=nil;
local skinDesc=""
local modelID=nil
local changeInfo=nil;
local changeData=nil;
this.ClickBtn=nil;
local langID=nil;
local otherImgName=nil;
function Awake()
    roleItem = RoleTool.AddRole(iconParent, PlayCB, nil, false)
    CSAPI.AddEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.AddEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
    ShareView_NoticeScreenshotCompleted(nil);
end

function OnDestroy()
    RoleAudioPlayMgr:StopSound();
end

--data:ShopSkinInfo
function OnOpen()
    if data then
        CSAPI.SetGOActive(clicker,false)
        -- local hasEnter=data:HasEnterTween();
        -- local hasEnter=data:HasL2D();
        local hasEnter=false
        modelID=data:GetModelID();
        roleItem.Refresh(modelID, LoadImgType.SkinReward,function()
            if roleItem.CheckIn() and CSAPI.IsInternation() then --有反和谐且有入场动画
                roleItem.PlayIn(function()
                    ShowTween2(roleItem.CheckIn())
                end,iconParent);
            else
                PlayShowTween();
            end
        end,hasEnter)
        local cfg=data:GetSetCfg();
        ResUtil.SkinSetIcon:Load(setIcon,cfg.icon.."_w",true);
        local modelCfg=data:GetModelCfg();
        CSAPI.SetText(txt_set,modelCfg.desc);
        CSAPI.SetText(txt_roleName,modelCfg.key);
        CSAPI.SetText(txt_roleNameTips,modelCfg.englishName);
        local skin=RoleSkinMgr:GetSkinInfoByModelID(modelID);
        if skin~=nil then
            CSAPI.SetGOActive(limitObj,skin:IsLimitSkin());
        else
            CSAPI.SetGOActive(limitObj,false);
        end
        skinDesc = data:GetSkinDesc()
        changeInfo=data:GetChangeInfo()
    end
end

--不播放声音不会触发
function PlayCB(curCfg)
    -- Log(curCfg)
	if(not IsNil(gameObject)) then
		--local str = curCfg.script or ""
        local script = SettingMgr:GetSoundScript(curCfg)  or ""
		CSAPI.SetText(txt_desc, script)	
	end
end

function OnClickAnyway()
    if this.ClickBtn~=nil then
        this.ClickBtn()
    else
        CloseView()
    end
end

function CloseView()
    RoleAudioPlayMgr:StopSound();
    view:Close();
end

--播放获得动画
function PlayShowTween()
    --展示剪影 --680 从小变大 静止280——>播放特效 
    if roleItem.imgItemLua then
        roleItem.imgItemLua.SetBlack(true);
    elseif roleItem.live2DItemLua then
        roleItem.live2DItemLua.SetBlack(true);
    end
    CSAPI.SetGOActive(tween1,true);
    --播放特效
    FuncUtil:Call(function()
        ShowEffect(ShowTween2); 
    end, nil, 960)
end

function ShowTween2(isL2d)
    --显示角色立绘
    -- if roleItem.imgItemLua then
    -- roleItem.imgItemLua.SetBlack(false);
    -- end
    --显示粒子
    CSAPI.SetGOActive(fc_pifu_OutWhite,false);
    CSAPI.SetGOActive(effectNode,true);
    if isL2d then
        CSAPI.SetGOActive(tween3,true);
    else
        CSAPI.SetGOActive(tween2,true);
        CSAPI.SetGOActive(ShareBtntween,true);
    end
    CSAPI.SetGOActive(clicker,true)
    CSAPI.SetText(txt_desc, skinDesc)	
    if changeInfo then
        SetChangeInfo(changeInfo[1].cfg);
    end
    --播放语音
    -- roleItem.PlayVoice(RoleAudioType.get);
end

function SetChangeInfo(cfg)
    if cfg then
        local type=cfg.skinType;
        if type==3 then
            langID=18105;
            otherImgName="img_12_02";
        elseif type==4 then --形切
            langID=18106;
            otherImgName="img_12_03";
        elseif type==5 then
            langID=18104;
            otherImgName="img_12_01";
        end
        if langID~=nil then
            CSAPI.SetText(txt_other,LanguageMgr:GetByID(langID));
        end
        --加载图
        ResUtil.Card:Load(otherIcon, cfg.List_head);
        if otherImgName~=nil then
            local tempName=string.format("UIs/RoleSkinComm/%s.png",otherImgName);
            CSAPI.LoadImg(otherImgTips,tempName,true,nil,true);
        end
        CSAPI.SetGOActive(btnOther,true);
    else
        CSAPI.SetGOActive(btnOther,false);
    end
end

function ShowEffect(func)
     -- 自适应Baiping
     local arr = CSAPI.GetMainCanvasSize()
     CSAPI.SetGOActive(fc_pifu_ToWhite,true);
     CSAPI.SetScale(baiping2, arr.x, arr.y, 1)
     FuncUtil:Call(function()
        --显示角色立绘
        if roleItem.imgItemLua then
           roleItem.imgItemLua.SetBlack(false);
        elseif roleItem.live2DItemLua then
            roleItem.live2DItemLua.SetBlack(false);
        end
        CSAPI.SetGOActive(fc_pifu_ToWhite,false);
        CSAPI.SetGOActive(fc_pifu_OutWhite,true);
        CSAPI.SetScale(baiping, arr.x, arr.y, 1)
        --设置播放角色获得音效
        if modelID then
            RoleAudioPlayMgr:PlayByType(modelID, RoleAudioType.shopGet)
        end
        local spTips=data:GetShowTips(true);
        if spTips~=nil then
            Tips.ShowTips(spTips);
        end
        --播放第二段段
        if func~=nil then
            -- FuncUtil:Call(func, nil, 300)
            FuncUtil:Call(func, nil, 0)
        end
    end, nil, 350)
end

function OpenSearchView(data,loadImgType)
    if data~=nil then
        CSAPI.OpenView("RoleInfoAmplification", data,loadImgType)
    end
end

function OnClickOther()
    if changeInfo then
        local cfg=changeInfo[1].cfg;
        local type=changeInfo[1].type;
        if type==5 then --机神
            --和谐更改
            OpenSearchView({ cfg.id, type==SkinChangeResourceType.Image,false}, LoadImgType.Main)
            -- OpenSearchView({ cfg.id, type==SkinChangeResourceType.Spine,false}, LoadImgType.Main)
        elseif changeData then --变更展示信息
            changeData=nil;
            SetChangeInfo(cfg);
            SwitchChange();
        else
            changeData=changeInfo[1];
            SetChangeInfo(data:GetModelCfg());
            SwitchChange();
        end
    end
end

function SwitchChange()
    local modelCfg=nil;
    local hasEnter=false;
    if changeData then
        --刷新皮肤信息、加载新的皮肤
        modelCfg=changeData.cfg;
        skinDesc = modelCfg.skin_desc;
        modelID=modelCfg.id;
        hasEnter=modelCfg.hadAni==1;
    else
        hasEnter=data:HasEnterTween();
        -- local hasEnter=data:HasL2D();
        modelID=data:GetModelID();
        modelCfg=data:GetModelCfg();
        skinDesc = data:GetSkinDesc()
    end
    roleItem.Refresh(modelID, LoadImgType.SkinReward,nil,hasEnter);
    --刷新皮肤信息、加载新的皮肤
    CSAPI.SetText(txt_set,modelCfg.desc);
    CSAPI.SetText(txt_roleName,modelCfg.key);
    CSAPI.SetText(txt_roleNameTips,modelCfg.englishName);
    CSAPI.SetText(txt_desc, skinDesc)	
end
function OnClickShareBtn()
    CSAPI.OpenView("ShareView",{LocationSource=2})
end
--------------------------------------------用于奖励弹窗--------------------------------------------
function Init()
    CSAPI.SetGOActive(tween1, false)
    CSAPI.SetGOActive(tween2, false)
    CSAPI.SetGOActive(ShareBtntween,false);
    CSAPI.SetGOActive(tween3, false)
    CSAPI.SetGOActive(stars, false)
    CSAPI.SetGOActive(effectNode, false)
    CSAPI.SetGOActive(fc_pifu_OutWhite, false)
    CSAPI.SetGOActive(fc_pifu_ToWhite, false)
    CSAPI.SetGOActive(clicker, false)
    CSAPI.SetGOAlpha(nameObj,0)
    CSAPI.SetGOAlpha(img1,0)
    CSAPI.SetScale(bottom,1,0,1)
    CSAPI.SetRTSize(line1,1,600)
    CSAPI.SetRTSize(line2,1,600)
end

---截图前一帧通知
function ShareView_NoticeTheNextFrameScreenshot(Data)
    CSAPI.SetGOActive(ShareBtn, false)
end
---截图完成通知
function ShareView_NoticeScreenshotCompleted(Data)
    CSAPI.SetGOActive(ShareBtn,CSAPI.IsSharePicture())

end
function OnDestroy()
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
end