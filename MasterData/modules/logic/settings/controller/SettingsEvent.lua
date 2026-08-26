-- chunkname: @modules/logic/settings/controller/SettingsEvent.lua

module("modules.logic.settings.controller.SettingsEvent", package.seeall)

local SettingsEvent = {}

SettingsEvent.SelectCategory = 1
SettingsEvent.PlayCloseCategoryAnim = 2
SettingsEvent.OnChangeLangTxt = 3
SettingsEvent.OnChangeScrollValue = 4
SettingsEvent.OnChangeHDType = 5
SettingsEvent.OnDownloadPrepareStart = 100
SettingsEvent.OnNotEnoughDiskSpace = 101
SettingsEvent.OnDownloadStart = 102
SettingsEvent.OnDownloadProgressRefresh = 103
SettingsEvent.OnDownloadPackFail = 104
SettingsEvent.OnDownloadPackSuccess = 105
SettingsEvent.OnPackUnZipFail = 106
SettingsEvent.OnPackItemStateChange = 107
SettingsEvent.OnUnzipProgressRefresh = 108
SettingsEvent.OnUseCdkReplay = 200
SettingsEvent.OnMarkNeedDownloadChange = 301
SettingsEvent.OnChangeEnergyMode = 302
SettingsEvent.OnChangeSelecetDownloadVoicePack = 303
SettingsEvent.OnChangeVoiceType = 304
SettingsEvent.OnChangePushType = 401
SettingsEvent.OnSetVoiceRoleSelected = 501
SettingsEvent.OnCharVoiceTypeChanged = 502
SettingsEvent.OnSetVoiceRoleFiltered = 503
SettingsEvent.OnKeyMapChange = 601
SettingsEvent.OnKeyTipsChange = 602

return SettingsEvent
