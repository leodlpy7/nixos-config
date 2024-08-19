{ config, pkgs, sops, ... }:

{
  # where to find the secrets
  sops.secrets.wifi = {
    format = "binary";
    sopsFile = ../../resources/secrets/wifi;
  };

  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;
  networking.wireless.environmentFile = /run/secrets/wifi;

  networking.wireless.networks = {
    # hotspot
    Andromeda = {
      psk = "@ANDROMEDA_PSK@";
      priority = 1;
    };

    # wifi fscs hhu
    HHUD-Y = {
      psk = "@HHUD_Y_PSK@";
      priority = 3;
    };

    # wifi fsphy hhu
    LambdaAufDemEFeld = {
      psk = "@LAMBDA_AUF_DEM_E_FELD_PSK@";
      priority = 3;
    };

    # wifi printer fsnawi
    DIRECT-OIMFC-L2710DW_BR8d6f = {
      psk = "@PRINTER_FSNAWI@";
      priority = 1;
    };

    # hhu eduroam
    eduroam = let
      cacert = builtins.toFile "ca_cert.pam" "-----BEGIN CERTIFICATE-----
MIIDwzCCAqugAwIBAgIBATANBgkqhkiG9w0BAQsFADCBgjELMAkGA1UEBhMCREUx
KzApBgNVBAoMIlQtU3lzdGVtcyBFbnRlcnByaXNlIFNlcnZpY2VzIEdtYkgxHzAd
BgNVBAsMFlQtU3lzdGVtcyBUcnVzdCBDZW50ZXIxJTAjBgNVBAMMHFQtVGVsZVNl
YyBHbG9iYWxSb290IENsYXNzIDIwHhcNMDgxMDAxMTA0MDE0WhcNMzMxMDAxMjM1
OTU5WjCBgjELMAkGA1UEBhMCREUxKzApBgNVBAoMIlQtU3lzdGVtcyBFbnRlcnBy
aXNlIFNlcnZpY2VzIEdtYkgxHzAdBgNVBAsMFlQtU3lzdGVtcyBUcnVzdCBDZW50
ZXIxJTAjBgNVBAMMHFQtVGVsZVNlYyBHbG9iYWxSb290IENsYXNzIDIwggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqX9obX+hzkeXaXPSi5kfl82hVYAUd
AqSzm1nzHoqvNK38DcLZSBnuaY/JIPwhqgcZ7bBcrGXHX+0CfHt8LRvWurmAwhiC
FoT6ZrAIxlQjgeTNuUk/9k9uN0goOA/FvudocP05l03Sx5iRUKrERLMjfTlH6VJi
1hKTXrcxlkIF+3anHqP1wvzpesVsqXFP6st4vGCvx9702cu+fjOlbpSD8DT6Iavq
jnKgP6TeMFvvhk1qlVtDRKgQFRzlAVfFmPHmBiiRqiDFt1MmUUOyCxGVWOHAD3bZ
wI18gfNycJ5v/hqO2V81xrJvNHy+SE/iWjnX2J14np+GPgNeGYtEotXHAgMBAAGj
QjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBS/
WSA2AHmgoCJrjNXyYdK4LMuCSjANBgkqhkiG9w0BAQsFAAOCAQEAMQOiYQsfdOhy
NsZt+U2e+iKo4YFWz827n+qrkRk4r6p8FU3ztqONpfSO9kSpp+ghla0+AGIWiPAC
uvxhI+YzmzB6azZie60EI4RYZeLbK4rnJVM3YlNfvNoBYimipidx5joifsFvHZVw
IEoHNN/q/xWA5brXethbdXwFeilHfkCoMRN3zUA7tFFHei4R40cR3p1m0IvVVGb6
g1XqfMIpiRvpb7PO4gWEyS8+eIVibslfwXhjdFjASBgMmTnrpMwatXlajRWc2BQN
9noHV8cigwUtPJslJj0Ys6lDfMjIq2SPDqO/nBudMNva0Bkuqjzx+zOAduTNrRlP
BSeOE6Fuwg==
-----END CERTIFICATE-----";
    in {
       priority = 2;
       auth = ''
         key_mgmt=WPA-EAP
         pairwise=CCMP
         group=CCMP TKIP
         eap=TTLS
         ca_cert="${cacert}"
         identity="@EDUROAM_IDENTITY@"
         altsubject_match="DNS:radius.hhu.de"
         phase2="auth=PAP"
         password="@EDUROAM_PASSWORD@"
         anonymous_identity="eduroam@hhu.de"
      '';
    };

    # hhu guest wifi
    HHU-Gast = {
      priority = 1;
    };

    # wifi wohnheim
    PWiFi = {
      psk = "@PWiFi_PSK@";
      priority = 5;
    };

    # at home
    "to huus" = {
      psk = "@TOHUUS_PSK@";
      priority = 5;
    };

    "LevelOne-2.4G" = {
      psk = "@LEVELONE_2_4G_PSK";
      priority = 5;
    };
  };
}
