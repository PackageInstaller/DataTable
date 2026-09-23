local attrs = {};
local isClose = false;

function OnOpen()
    isClose = false
    -- 根据升级后的光环信息展示新增内容
    if data then
        local cfg = data.oldInfo:GetCfg();
        CSAPI.SetText(txtLv1, tostring(data.oldInfo:GetLv()));
        CSAPI.SetText(txtLv2, tostring(data.newInfo:GetLv()));
        -- 统计每个等级可以得到的加成和解锁的特殊功能
        if cfg then
            local list = {};
            local conds = {};
            if cfg.slotCond then
                for k, v in ipairs(cfg.slotCond) do
                    if v ~= 0 then -- 0代表没有条件
                        local haloCondition = HaloLockCondition.New();
                        haloCondition:InitCfg(v);
                        haloCondition:SetIndex(k);
                        if haloCondition:GetType() == HaloEnum.HaloCondType.HaloLv then
                            conds[haloCondition:GetParam()] = haloCondition
                        end
                    end
                end
            end
            local isShowBase = data.newInfo:GetUpdateShow();
            if isShowBase then
                local oldTypes = cfg.infos[data.oldInfo:GetLv()].use_types
                local types = cfg.infos[data.newInfo:GetLv()].use_types
                if types ~= nil then -- 记录当前等级属性
                    for k, v in ipairs(types) do
                        local eCfg = Cfgs.CfgCardPropertyEnum:GetByID(v);
                        if eCfg then
                            local _num = cfg.infos[data.newInfo:GetLv()][eCfg.sFieldName] or 0
                            local lvStr = LanguageMgr:GetByID(1033) .. data.newInfo:GetLv()
                            local has = false;
                            local isNew = true;
                            for _, val in ipairs(oldTypes) do
                                if val == v then
                                    local _num2 = cfg.infos[data.oldInfo:GetLv()][eCfg.sFieldName] or 0
                                    has = _num2 < _num;
                                    isNew = false;
                                    break
                                end
                            end
                            table.insert(list, {
                                name = eCfg.sName,
                                val = HaloUtil.GetPropertyValueStr(eCfg.sFieldName, _num),
                                lv = lvStr,
                                lvNum = data.newInfo:GetLv(),
                                isNew = isNew
                            });
                        end
                    end
                end
            else
                -- 记录特性
                for i = data.oldInfo:GetLv(), data.newInfo:GetLv() do
                    local v = cfg.infos[i];
                    -- if conds[tostring(v.index)]~=nil then
                    --     table.insert(list,{desc=LanguageMgr:GetByID(100020),lv=LanguageMgr:GetByID(1033)..v.index,lvNum=v.index});
                    -- end
                    if v.coorId and v.index ~= 1 and i ~= data.oldInfo:GetLv() then -- 1级的站位默认开启
                        local isUnLock = false;
                        local condIdx = 0;
                        for i = 1, #cfg.infos do
                            if cfg.infos[i].coorId ~= nil then
                                condIdx = condIdx + 1;
                                local cond = conds[tostring(condIdx)] ~= nil and conds[tostring(condIdx)] or nil;
                                if i == v.index and
                                    ((cond ~= nil and cond:IsPass(data.card, data.newInfo:GetLv())) or cond == nil) then
                                    isUnLock = true;
                                    break
                                end
                            end
                        end
                        if isUnLock then
                            table.insert(list, {
                                desc = LanguageMgr:GetByID(100036),
                                lv = LanguageMgr:GetByID(1033) .. v.index,
                                lvNum = v.index,
                                isNew = isUnLock
                            });
                        end
                    end
                end
                local effectCfg = data.newInfo:GetSpecialCfg()
                local oldEffect = data.oldInfo:GetSpecialCfg()
                if effectCfg ~= nil then -- 自身属性加成
                    for k, v in ipairs(effectCfg.use_types) do
                        local eCfg = Cfgs.CfgCardPropertyEnum:GetByID(v);
                        if eCfg then
                            local _num = effectCfg[eCfg.sFieldName] or 0
                            local lvStr = LanguageMgr:GetByID(1033) .. data.newInfo:GetLv()
                            -- local lvStr=LanguageMgr:GetByID(100041)
                            local isNew = false;
                            if oldEffect ~= nil then
                                local _num2 = oldEffect[eCfg.sFieldName] or 0;
                                isNew = _num2 == 0
                            end
                            table.insert(list, {
                                name = eCfg.sName,
                                val = HaloUtil.GetPropertyValueStr(eCfg.sFieldName, _num),
                                lv = lvStr,
                                lvNum = data.newInfo:GetLv(),
                                isNew = isNew
                            });
                        end
                    end
                end
            end
            -- table.sort(list,function(a,b)
            --     return b.lvNum<a.lvNum
            -- end)
            ItemUtil.AddItems("AttributeNew2/HaloAttributeItem", attrs, list, layout)
        end
    end
end

function OnClickClose()
    if isClose then
        return
    end
    isClose = true
    CSAPI.ApplyAction(gameObject, "View_Close_Fade", function()
        view:Close()
        PopupPackMgr:CheckByCondition({1})
    end)
end
