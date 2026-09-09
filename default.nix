{
  lib,
  stdenv,
  buildNpmPackage,
  xdg-utils,
}:

buildNpmPackage {
  pname = "mdopen";
  version = (lib.importJSON ./package.json).version;

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./package.json
      ./package-lock.json
      ./render.mjs
      ./styles.mjs
      ./annotate.mjs
      ./LICENSE
    ];
  };

  npmDepsHash = "sha256-gUmhXgTF05CiH+/S5t7UG2R+Y0gO8D3vVyIHIC71eGQ=";
  dontNpmBuild = true;

  makeWrapperArgs = lib.optionals stdenv.hostPlatform.isLinux [
    "--prefix PATH : ${lib.makeBinPath [ xdg-utils ]}"
  ];

  meta = {
    description = "Render Markdown and HTML with browser annotations for coding agents";
    homepage = "https://github.com/dahbiahmed/mdopen";
    license = lib.licenses.mit;
    mainProgram = "mdopen";
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
