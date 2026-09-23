-- 光环信息界面
local eventMgr = nil;
local cardData = nil;
local btnList = {};
local attrItems = {};
local attrItems2 = {};
local curHaloInfo = nil;
local rangItem = nil;
function Awake()
    eventMgr = ViewEvent.New();
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(_data)
    if _data then
        cardData = _data;
        curHaloInfo = cardData:GetHaloInfo();
        if rangItem == nil then
            ResUtil:CreateUIGOAsync("Halo/HaloRangItem", iconObj, function(go)
                rangItem = ComUtil.GetLuaTable(go);
                rangItem.Refresh(curHaloInfo:GetCurCoordPos(), cardData);
                CSAPI.SetAnchor(go, 0, 0);
            end);
        else
            rangItem.Refresh(curHaloInfo:GetCurCoordPos(), cardData);
        end
    end
    if curHaloInfo ~= nil then
        CSAPI.SetText(lvObj, tostring(curHaloInfo:GetLv()));
        InitAttrs();
        -- 设置特殊效果说明
        local spCfg, spLv = curHaloInfo:GetSpecialCfg();
        if spCfg and spLv and curHaloInfo:GetLv() >= spLv then
            CSAPI.SetTextColorByCode(txtDesc, "cdcdcd");
            InitAttrs2();
            CSAPI.SetGOActive(attrLayout2, true);
            CSAPI.SetGOActive(txtDesc, false);
        else
            CSAPI.SetGOActive(attrLayout2, false);
            CSAPI.SetGOActive(txtDesc, true);
        end

        -- 生成阵型按钮
        local btnDatas = curHaloInfo:GetCoordInfos()
        ItemUtil.AddItems("Halo/HaloBtnItem", btnList, btnDatas, bottomObj, OnClickBtnItem, 1, curHaloInfo)
    end
end

function InitAttrs()
    -- 生成属性
    local attrDatas = HaloUtil.CountHaloAddtion(curHaloInfo, cardData, "c3c3c8", "ffc146", "7f7f84", "7f7f84", true);
    ItemUtil.AddItems("AttributeNew2/HaloAttributeItem3", attrItems, attrDatas, attrLayout)
end

function InitAttrs2()
    -- 生成自身加成属性
    local spCfg = curHaloInfo:GetSpecialCfg();
    local attrDatas = {};
    if spCfg then
        for k, v in ipairs(spCfg.use_types) do
            local eCfg = Cfgs.CfgCardPropertyEnum:GetByID(v);
            if eCfg then
                local _num = spCfg[eCfg.sFieldName] or 0
                table.insert(attrDatas, {
                    cfg = eCfg,
                    addtive = HaloUtil.GetPropertyValueStr(eCfg.sFieldName, _num),
                    addtiveNum =_num,
                    val1Color = "c3c3c8",
                    val2Color = "ffc146"
                });
            end
        end
    end
    ItemUtil.AddItems("AttributeNew2/HaloAttributeItem2", attrItems2, attrDatas, attrLayout2)
end

function OnClickBtnItem(lua)
    if cardData and curHaloInfo:GetLv() >= lua.data:GetLockLv() then
        local coord = curHaloInfo:GetCurCoord();
        if coord and coord:GetID() ~= lua.data:GetID() then
            -- 打开切换确认窗口
            CSAPI.OpenView("HaloReplace", {
                card = cardData,
                targetPos = lua.data
            });
        end
    end
end

-- --打开编队界面
-- function OnClickTeam()

-- end
