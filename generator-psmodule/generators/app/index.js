'use strict';
const Generator = require('yeoman-generator');
const chalk = require('chalk');
const yosay = require('yosay');
const uuid = require('uuid/v4');
const mkdir = require('make-dir');

module.exports = class extends Generator {
  prompting() {
    this.log(
      yosay(`Welcome to the ${chalk.blue('PSMODULE')} generator dawg!`)
    );

    const prompts = [
      {
        type: 'input',
        name: 'moduleName',
        message: 'What is the name of the module?',
        default: this.contextRoot.split("\\").pop()
      },
      {
        type: 'input',
        name: 'author',
        message: 'What is the name of the author?',
        default: 'ThatGuy'
      },
      {
        type: 'input',
        name: 'description',
        message: 'What is the description of the module?'
      }
    ];

    return this.prompt(prompts).then(props => {
      this.props = props;
      this.props.moduleGuid = uuid();

      const currentDate = new Date();
      this.props.currentDate = currentDate.toLocaleDateString("fr-ca");

      this.props.copyright = `(c) ${currentDate.getFullYear()} ${this.props.author}. All rights reserved.`
    });
  }

  writing() {
    // Generating folder structure
    mkdir("Sources");
    mkdir("Tests");

    // Sources section
    this.fs.copy(
      this.templatePath("Sources/Dummy.ps1"), 
      this.destinationPath("Sources/Dummy.ps1")
    );

    this.fs.copy(
      this.templatePath("Sources/ModuleName.psm1"), 
      this.destinationPath(`Sources/${this.props.moduleName}.psm1`)
    );

    this.fs.copyTpl(
      this.templatePath("Sources/ModuleName.psd1"),
      this.destinationPath(`Sources/${this.props.moduleName}.psd1`),
      {
        moduleName: this.props.moduleName,
        moduleGuid: this.props.moduleGuid,
        author: this.props.author,
        description: this.props.description,
        currentDate: this.props.currentDate,
        copyright: this.props.copyright
      }
    )

    // Test sections
    this.fs.copy(
      this.templatePath("Tests/Dummy.tests.ps1"),
      this.destinationPath("Tests/Dummy.tests.ps1")
    )

    this.fs.copy(
      this.templatePath("Tests/ScriptAnalyzer.tests.ps1"),
      this.destinationPath("Tests/ScriptAnalyzer.tests.ps1")
    )

    this.fs.copy(
      this.templatePath("Tests/Test Data/Dummy/dummyfile.json"),
      this.destinationPath("Tests/Test Data/Dummy/dummyfile.json")
    )

    // Module root section
    this.fs.copy(
      this.templatePath("Install-ToolingModules.ps1"),
      this.destinationPath("Install-ToolingModules.ps1")
    )

    this.fs.copyTpl(
      this.templatePath("Publish-DummyModule.ps1"),
      this.destinationPath(`Publish-${this.props.moduleName}.ps1`),
      {
        moduleName: this.props.moduleName
      }
    )
  }
};
