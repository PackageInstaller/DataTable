local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        CSAPI.SetText(txtCourse, cfg.moduleDesc)
    end
end

function OnClickCourse()
    local cfgCourse = Cfgs.CfgModuleInfo:GetByID(cfg.moduleId)
    if cfgCourse then
        CSAPI.OpenView("ModuleInfoView", cfgCourse)
    end
end