local recordTime=nil;
local grids={};
local slotNodes={};
local selectSlot=-1;--当前选择的位置
local skillPoints=nil;
local attrView=nil;
local selectView=nil;
local eventMgr=nil;
local isSuitSelect=nil;
local card=nil;
local slotEffs={};
local ViewTop
function Awake()
    ViewTop=UIUtil:AddTop2("RoleEquip",gameObject,OnClickReturn,OnClickHomeFunc,{})
    slotNodes={top,left,center,right,bottom};
    slotEffs={
        {t=tt_eff,b=tb_eff},
        {t=lt_eff,b=lb_eff},
        {t=ct_eff,b=cb_eff},
        {t=rt_eff,b=rb_eff},
        {t=bt_eff,b=bb_eff}
    }
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Equip_Change, OnEquipChange);
    eventMgr:AddListener(EventType.Equip_Down_Ret,OnDownRet);
    eventMgr:AddListener(EventType.Equip_Ups_Ret,OnUpsRet);
    eventMgr:AddListener(EventType.Equip_UpOne_Ret,OnUpOneRet);
    eventMgr:AddListener(EventType.Equip_Select_Change,OnEquipSelectChange);
    eventMgr:AddListener(EventType.EquipCore_Slot_Change,OnSlotChange);
    eventMgr:AddListener(EventType.Equip_Suit_Click,OnClickSuitItem);
    eventMgr:AddListener(EventType.Equip_SetLock_Ret, OnEquipChange);
    eventMgr:AddListener(EventType.Equip_TweenMask_State,SetTweenMask);
    -- eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed);
    -- eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpen);
    recordTime=CSAPI.GetRealTime();
end 

function OnClickHomeFunc()
	UIUtil:ToHome();	
end

function OnDisable()
    RecordMgr:Save(RecordMode.View,recordTime,"ui_id=" .. RecordViews.Equip);	
end

function OnDestroy()
	eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnGuideFind(d)
    local guidePos = this[d.goKey];
    if(guidePos)then
        d.targetPos = guidePos;
        d.callBack(d);
    end
end

--_data ={card=CharacterCardsData,slot=指定位置} openSetting=1:正常模式，=2表示查看
function OnOpen()
    openSetting=openSetting or 1;
    card=data.card;
    selectSlot=data.slot or -1;
    SetEffectParent(false);
    Refresh();
end

function Refresh()
    --初始化装备槽
    RefreshGrids();
    local skills=card:GetEquipSkillPoint();
    if skills then --读取装备技能信息
        skillPoints={}; --用于记录装备技能点数
        for k,v in ipairs(skills.eskills) do
            local skillCfg = Cfgs.CfgEquipSkill:GetByID(v);
            if skillCfg then
                skillPoints[skillCfg.group]=skillCfg.nLv;
            end
        end
    end
    RefreshAttrs();
    RefreshSelectView();
    SetCleanState();
    SetSuitBtn();
end

function SetSuitBtn()
    if selectSlot~=-1 and not isSuitSelect then
        CSAPI.SetGOActive(btnAuto,true)
        CSAPI.SetGOActive(btnSuitUp,false)
    else 
        CSAPI.SetGOActive(btnAuto,not isSuitSelect)
        CSAPI.SetGOActive(btnSuitUp,isSuitSelect)
    end
end

function RefreshSelectView()
    --创建子物体
    if selectView==nil then
        ResUtil:CreateUIGOAsync("EquipSelect/EquipSelectView",nChild,function(go)
            selectView=ComUtil.GetLuaTable(go);
            selectView.SetData({card=card,slot=selectSlot})
        end);
    else
        selectView.SetData({card=card,slot=selectSlot})
    end
end
--创建/刷新属性面板
function RefreshAttrs()
    if attrView==nil then
        --创建子物体
        ResUtil:CreateUIGOAsync("RoleEquip/RoleEquipAttribute",nChild,function(go)
            attrView=ComUtil.GetLuaTable(go);
            attrView.Refresh(card)
        end);
    else
        attrView.Refresh(card)
    end
end

--创建/刷新装备槽
function RefreshGrids()
    local elseData={
        isFight=IsInFight(),
        selectSlot=selectSlot,
        isShowBtn=openSetting==1,
    }
    if #grids<=0 then
        for i = 1, 5, 1 do
            ResUtil:CreateUIGOAsync("RoleEquip/EquipGrid",slotNodes[i],function(go)
                local lua=ComUtil.GetLuaTable(go);
                lua.SetSlot(i);
                if card then
                    lua.Refresh(card:GetEquipBySlot(i),elseData);
                else
                    lua.InitNull();
                end
                table.insert(grids,lua)
            end)
        end
    else
        for k, v in ipairs(grids) do
            if card then
                grids[k].Refresh(card:GetEquipBySlot(k),elseData);
            else
                grids[k].InitNull();
            end
        end
    end
end

--卡牌是否在战斗中
function IsInFight()
    local cid=card:GetID();
    if cid then
        local isAssist=FriendMgr:IsAssist(cid);
        if isAssist==true then
            Tips.ShowTips(LanguageMgr:GetTips(12006));
            return true;
        end
        local isFight=TeamMgr:GetCardIsDuplicate(cid);
        if isFight then
            Tips.ShowTips(LanguageMgr:GetTips(12007))
            return true;
        end
    end
    return false;
end

-- --自动穿戴
function OnClickAuto()
    if not IsInFight() then
        AutoSelectEquip();
    end
    -- if equipCore then
    --     equipCore.Init({card=card},EquipCoreSetting.Select);
    -- end
    -- CSAPI.OpenView("EquipSelectView",{card=card},2,function(go)
    --     selectView=ComUtil.GetLuaTable(go);
    -- end);
    -- CSAPI.SetGOActive(mask,true);
end

function OnEquipSelectChange(eventData)
    -- if equipCore then
    --     equipCore.Init({card=card,slot=eventData:GetSlot()},EquipCoreSetting.Select);
    -- end
    SetSelectGrid(eventData.slot,eventData.isSuitSelect);
end

--玩家点击装备槽切换时
function OnSlotChange(eventData)
    selectSlot=eventData and eventData.slot or 1;
    SetSelectGrid(eventData.slot)
end

function SetSelectGrid(slot,_isSuitSelect)
    selectSlot=slot;
    for k, v in ipairs(grids) do
        v.SetSelect(k==slot);
    end
    isSuitSelect=_isSuitSelect;
    SetSuitBtn();
end

function OnClickSuitItem(tab)
    isSuitSelect=#tab.data>0;
    SetSuitBtn();
end

function OnEquipChange()
    -- Refresh()
    RefreshGrids()
    RefreshAttrs();
    SetCleanState();
end

function SetTweenMask(isShow)
    CSAPI.SetGOActive(tweenMask,isShow==true);
end

--设置清理按钮状态
function SetCleanState()
    local equips=card:GetEquips();
    if card and equips~=nil and next(equips) then
        -- CSAPI.SetGOAlpha(btnClean,1)
        UIUtil:SetBtnState(btnClean,true);
    else
        -- CSAPI.SetGOAlpha(btnClean,0.5)
        UIUtil:SetBtnState(btnClean,false);
    end
end

function OnClickPrefab()
    CSAPI.OpenView("EquipPrefab",card)
end

--切换到套装页签
-- function OnClickSuit()
--     if not IsInFight() then
--         EventMgr.Dispatch(EventType.EquipCore_Slot_Change,{slot=-1,disReplace=true});
--     end
-- end

--选中套装的情况下，一键替换套装
function OnClickSuitUp()
    if not IsInFight() then
        EventMgr.Dispatch(EventType.Equip_Click_SuitUps);
    end
end

--一键卸载
function OnClickClean()
    local equips=card:GetEquips();
    if IsInFight()==false and openSetting~=EquipCoreSetting.Search and equips~=nil then
        local ids={};
        for k,v in pairs(equips) do
            table.insert(ids,v:GetID());
        end
        if #ids>=1 then
            isClean=true
            EquipProto:EquipDown(ids); 
            -- EventMgr.Dispatch(EventType.Equip_Change)
        end
    end
end

--卸载回调
function OnDownRet()
    if card then
        card=RoleMgr:GetData(card:GetID())
    end
    if isClean then
        Tips.ShowTips(LanguageMgr:GetByID(23060))
        isClean=false;
    else
        Tips.ShowTips(LanguageMgr:GetByID(23059))
    end
    OnEquipChange();
    -- EventMgr.Dispatch(EventType.Equip_Change)
end

function OnUpOneRet(eventData)
    Tips.ShowTips(LanguageMgr:GetByID(23056))
    if eventData then
        local slots={};
        if eventData.equipId then
            local equip=EquipMgr:GetEquip(eventData.equipId);
            table.insert(slots,equip:GetSlot());
        end
        PlayUpEffect(slots);
    end
    OnEquipChange();
end

function OnUpsRet(proto)
    if proto then
        local slots={};
        if proto.up_ids then
            for k,v in ipairs(proto.up_ids) do
                local equip=EquipMgr:GetEquip(v);
                table.insert(slots,equip:GetSlot());
            end
        end
        PlayUpEffect(slots);
    end
    Tips.ShowTips(LanguageMgr:GetByID(23058))
end

function PlayUpEffect(slots)
    if slots and #slots>0 then
        SetEffectParent(true);
        for k,v in ipairs(slots) do
            CSAPI.SetGOActive(slotEffs[v].t,true);
            CSAPI.SetGOActive(slotEffs[v].b,true);
        end
        FuncUtil:Call(function()
            for k,v in ipairs(slots) do
                CSAPI.SetGOActive(slotEffs[v].t,false);
            end
        end,nil,417);
        FuncUtil:Call(function()
            for k,v in ipairs(slots) do
                CSAPI.SetGOActive(slotEffs[v].b,false);
            end
            SetEffectParent(false);
        end,nil,833);
    end
end

function SetEffectParent(isEffect)
    if not isEffect then
        CSAPI.SetParent(equipNodes,itemRoot);
        CSAPI.SetParent(nChild,child);
    else
        CSAPI.SetParent(equipNodes,centerLayer);
        CSAPI.SetParent(nChild,eChild);
    end
end

--处理特效层级问题
-- function OnViewOpen(viewKey)
--     if viewKey=="EquipStreng" then
-- 		SetEffectParent(false);
-- 	end
-- end

-- --处理特效层级问题
-- function OnViewClosed(viewKey)
--     if viewKey=="EquipStreng" then
--         SetEffectParent(true);
-- 	end
-- end

-- --跳转到技能详情界面
-- function OnClickSkillInfo()
--     --打开
--     CSAPI.OpenView("RoleEquipSkillFull",{card=card,skillPoints=skillPoints});
-- end

function OnClickBG()
    EventMgr.Dispatch(EventType.Equip_Click_BG)
end

--自动穿戴装备
function AutoSelectEquip()
    -- local equipList=EquipMgr:GetAllEquipArr(nil,false);
    -- local slotEquips={};
    -- if equipList then
    --     --根据等级>品质>ID>属性进行查找
    --     for k,v in ipairs(equipList) do
    --         if (v:IsEquipped() and v:GetCardId()==card:GetID()) or not v:IsEquipped() then--在自己穿戴的装备和未穿戴的中查找
    --             local slot=v:GetSlot();
    --             local score=v:GetScore();
    --             if slotEquips[slot]==nil or (slotEquips[slot]~=nil and slotEquips[slot].score<score) then
    --                 slotEquips[slot]=slotEquips[slot] or {};
    --                 slotEquips[slot].id=v:GetID();
    --                 slotEquips[slot].score=score;
    --             end
    --         end
    --     end
    -- end
    -- local ids={};
    -- local equips=card:GetEquips();
    -- for k,v in pairs(slotEquips) do
    --     local hasEquip=false;
    --     if equips then
    --         for _,val in ipairs(equips) do
    --             if val:GetID()==v.id then
    --                 hasEquip=true;
    --                 break;
    --             end
    --         end
    --     end
    --     if hasEquip==false then
    --         table.insert(ids,v.id);
    --     end
    -- end
    local ids=EquipMgr:SearchBeastEquips(card:GetID());
    if #ids>0 then
        EquipProto:EquipUps(card:GetID(),ids,function()
            -- EventMgr.Dispatch(EventType.Equip_Change);
            Tips.ShowTips(LanguageMgr:GetTips(12015));
            OnEquipChange();
        end);
    else
        Tips.ShowTips(LanguageMgr:GetTips(12000));
    end
end

function OnClickReturn()
    view:Close();
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if(not IsNil(selectView)) then
        ---填写退出代码逻辑/接口
        if  selectView.OnClickRepalceMask and selectView.repalceMask.gameObject.activeInHierarchy then
            selectView.OnClickRepalceMask();
        else
            if  ViewTop.OnClickBack then
                ViewTop.OnClickBack();
            end
        end
    else
        if  ViewTop.OnClickBack then
            ViewTop.OnClickBack();
        end
    end
end



----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
grids=nil;
top=nil;
left=nil;
center=nil;
right=nil;
bottom=nil;
mask=nil;
itemRoot=nil;
tabs=nil;
btnSwitch=nil;
btnPrefab=nil;
btnClean=nil;
view=nil;
end
----#End#----