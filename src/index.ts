import axios from 'axios';

const clientId = 'squ_a5dac0c9e48b1f7ff3e7ee0b0a3ec7e90b52a9ab';
const credentials = `${clientId}:`;
const token = Buffer.from(credentials).toString('base64')

axios.defaults.baseURL = 'http://localhost:9000';
axios.defaults.headers.common.Authorization = `Basic ${token}`;

type Metric = {
  id: string;
  key: string;
  type: string;
  name: string;
  description: string;
  domain: string;
  direction: number;
  qualitative: boolean;
  hidden: boolean;
}

type MetricsResponse = {
  metrics: Array<Metric>;
}

async function searchMetricsKeys() {
  const response = await axios.get<MetricsResponse>('/api/metrics/search', {
    params: {

    },
  });
  console.log('Metrics keys:', response.data.metrics.length);
  return response
    .data
    .metrics
    .filter((metric) => metric.domain?.includes('OWASP'));
}

type Measure = {
  metric: string;
  value: string;
  bestValue: boolean;
};

type MeasuresResponse = {
  component: {
    measures: Array<Measure>;
  };
}

const METRICS = [
  'low_severity_vulns',
  'medium_severity_vulns',
  'high_severity_vulns',
  'inherited_risk_score',
  // 'report',
  'total_dependencies',
  'vulnerable_dependencies',
]

async function getMeasures() {
  const response = await axios.get<MeasuresResponse>('/api/measures/component', {
    params: {
      component: 'DGS-Health-Panel-Front',
      metricKeys: METRICS.join(','),
    },
  });

  console.log('Measures data:', response.data.component.measures.length);

  console.log('Measures:', response.data.component.measures);
}

async function main() {
  // const metrics = await searchMetricsKeys();

  await getMeasures();
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
